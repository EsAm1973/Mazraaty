import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mazraaty/Core/errors/failure.dart';
import 'package:mazraaty/Features/plant_library/data/models/ai_chat_response.dart';
import 'package:mazraaty/Features/plant_library/data/repos/AI%20Chat%20Repo/ai_chat_repo.dart';
import 'package:mazraaty/Features/plant_library/data/repos/AI%20Chat%20Repo/ai_chat_repo_impl.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/chat_message_wrapper.dart';

part 'ai_chat_state.dart';

class AIChatCubit extends Cubit<AIChatState> {
  final AIChatRepo _aiChatRepo;
  final List<AIChatResponse> _messages = [];
  // Flag to prevent duplicate API calls for the same message
  bool _isProcessing = false;
  // Minimum duration to show loading state (in milliseconds)
  static const int _minimumLoadingDuration = 2500;

  AIChatCubit(this._aiChatRepo) : super(AIChatInitial());

  // Getter to expose messages while keeping the field private
  List<AIChatResponse> get messages => List.unmodifiable(_messages);

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty || _isProcessing) return;

    try {
      _isProcessing = true;
      
      // Create a unique timestamp for this message
      final userMessage = AIChatResponse(
        message: message,
        isUser: true,
      );
      
      // Add user message to the list if it's not a duplicate
      if (!_isDuplicateMessage(userMessage)) {
        _messages.add(userMessage);
        // Emit a success state immediately with just the user message added
        // This prevents screen reset and shows user input instantly
        emit(AIChatSuccess(List.from(_messages)));
      }

      // Immediately start loading state with a longer delay
      // This ensures UI has time to render before animation starts
      await Future.delayed(const Duration(milliseconds: 300));
      final loadingStartTime = DateTime.now();
      emit(AIChatLoading());

      // Send message to API - add additional delay for UI to stabilize
      await Future.delayed(const Duration(milliseconds: 100));
      final result = await _aiChatRepo.sendMessage(message);

      // Calculate how much time has passed since loading started
      final elapsedTime =
          DateTime.now().difference(loadingStartTime).inMilliseconds;

      // If less than minimum loading time has passed, wait the remaining time
      if (elapsedTime < _minimumLoadingDuration) {
        await Future.delayed(
            Duration(milliseconds: _minimumLoadingDuration - elapsedTime));
      }

      result.fold(
        (failure) {
          emit(AIChatError(failure));
          _isProcessing = false;
        },
        (response) {
          // Only add the response if it's not a duplicate
          if (!_isDuplicateMessage(response)) {
            _messages.add(response);
          }
          
          // Create a new list to avoid reference issues
          final updatedMessages = List<AIChatResponse>.from(_messages);
          emit(AIChatSuccess(updatedMessages));
          _isProcessing = false;
        },
      );
    } catch (e) {
      debugPrint('Error in sendMessage: $e');
      emit(AIChatError(ServerFailure(errorMessage: e.toString())));
      _isProcessing = false;
    }
  }

  Future<void> getPlantDetails(String plantName) async {
    if (plantName.trim().isEmpty || _isProcessing) return;

    try {
      _isProcessing = true;
      
      // Add user message about the plant with a more conversational tone
      final userMessage = AIChatResponse(
        message: "Can you help me with some questions about the $plantName plant?",
        isUser: true,
      );
      
      // Only add if not duplicate
      if (!_isDuplicateMessage(userMessage)) {
        _messages.add(userMessage);
        // Emit success state immediately for better UI response
        emit(AIChatSuccess(List.from(_messages)));
      }

      // Small delay to let UI update before showing loading state
      await Future.delayed(const Duration(milliseconds: 50));
      
      // Start loading state and record the start time
      final loadingStartTime = DateTime.now();
      emit(AIChatLoading());

      // Get plant details with improved prompt
      final result = await _aiChatRepo.getPlantDetails(plantName);

      // Calculate how much time has passed since loading started
      final elapsedTime =
          DateTime.now().difference(loadingStartTime).inMilliseconds;

      // If less than minimum loading time has passed, wait the remaining time
      if (elapsedTime < _minimumLoadingDuration) {
        await Future.delayed(
            Duration(milliseconds: _minimumLoadingDuration - elapsedTime));
      }

      result.fold(
        (failure) {
          emit(AIChatError(failure));
          _isProcessing = false;
        },
        (response) {
          // Only add if not duplicate
          if (!_isDuplicateMessage(response)) {
            _messages.add(response);
          }
          
          // Create a new list to avoid reference issues
          final updatedMessages = List<AIChatResponse>.from(_messages);
          emit(AIChatSuccess(updatedMessages));
          _isProcessing = false;
        },
      );
    } catch (e) {
      debugPrint('Error in getPlantDetails: $e');
      emit(AIChatError(ServerFailure(errorMessage: e.toString())));
      _isProcessing = false;
    }
  }
  
  // Helper method to check for duplicates
  bool _isDuplicateMessage(AIChatResponse newMessage) {
    final isDuplicate = _messages.any((existingMessage) =>
        existingMessage.message == newMessage.message &&
        existingMessage.isUser == newMessage.isUser &&
        // Check if timestamps are close (within 2 seconds)
        (existingMessage.timestamp.difference(newMessage.timestamp).inSeconds.abs() < 2));
    
    if (isDuplicate) {
      debugPrint('Duplicate message detected: ${newMessage.message.substring(0, min(20, newMessage.message.length))}...');
    }
    
    return isDuplicate;
  }

  void clearChat() {
    _messages.clear();
    _isProcessing = false;
    
    // Clear animation history to prevent old animations from being remembered
    ChatMessageBubbleWrapper.clearAnimationHistory();
    
    // Clear conversation history in the service
    if (_aiChatRepo is AIChatRepoImpl) {
      final service = (_aiChatRepo as AIChatRepoImpl).aiChatService;
      service.clearConversation();
    }
    emit(AIChatInitial());
  }
  
  // Helper for min function
  int min(int a, int b) => a < b ? a : b;
}
