import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AIChatService {
  final Dio _dio;
  final String apiKey;
  // Maintain conversation history
  final List<Map<String, String>> _conversationHistory = [];
  // Track which messages we've already processed
  bool _isNewConversation = true;
  int _lastProcessedIndex = 0;

  AIChatService({required this.apiKey})
      : _dio = Dio(BaseOptions(
          baseUrl: 'https://openrouter.ai/api/v1',
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
          },
          // Add longer timeout
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        )) {
    // Initialize with system message
    _conversationHistory.add({
      'role': 'system',
      'content':
          'You are a plant and agriculture expert. Provide helpful information about plants, gardening, and agriculture. Only respond to plant and agriculture-related questions. Your responses should be detailed but concise. Do not repeat information from previous responses.'
    });
  }

  Future<Response> sendChatRequest(String prompt) async {
    try {
      // Add the new user message to history
      _conversationHistory.add({'role': 'user', 'content': prompt});

      // Print for debugging
      debugPrint('Sending message: $prompt');
      debugPrint('Full conversation history: ${_conversationHistory.length} messages');

      // Send the entire conversation history 
      // The API needs full context to generate accurate responses
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'deepseek/deepseek-r1:free',
          'messages': _conversationHistory,
          'temperature': 0.7,
          'max_tokens': 1024,
        },
      );

      // Extract just the assistant's response text
      String assistantResponse = '';
      if (response.data != null &&
          response.data['choices'] != null &&
          response.data['choices'].isNotEmpty &&
          response.data['choices'][0]['message'] != null) {
        assistantResponse = response.data['choices'][0]['message']['content'];

        // Add the assistant's response to the history
        _conversationHistory
            .add({'role': 'assistant', 'content': assistantResponse});
        
        // Update the last processed index
        _lastProcessedIndex = _conversationHistory.length - 1;
        _isNewConversation = false;

        // Generate a timestamp for the response
        final now = DateTime.now().toIso8601String();

        // Create a completely new response structure for the UI
        // This ensures we don't have any references to the original response
        final modifiedResponseData = {
          'message': assistantResponse,
          'isUser': false,
          'timestamp': now,
        };

        // Return the modified response
        return Response(
          requestOptions: response.requestOptions,
          data: modifiedResponseData,
          statusCode: response.statusCode,
          headers: response.headers,
        );
      }

      return response;
    } catch (e) {
      debugPrint('API Error: $e');
      rethrow;
    }
  }

  // Method to clear conversation history (except system message)
  void clearConversation() {
    final systemMessage = _conversationHistory.first;
    _conversationHistory.clear();
    _conversationHistory.add(systemMessage);
    _isNewConversation = true;
    _lastProcessedIndex = 0;
  }
}
