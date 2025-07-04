part of 'ai_chat_cubit.dart';

abstract class AIChatState extends Equatable {
  const AIChatState();

  @override
  List<Object?> get props => [];
}

class AIChatInitial extends AIChatState {}

class AIChatLoading extends AIChatState {}

class AIChatSuccess extends AIChatState {
  final List<AIChatResponse> messages;

  const AIChatSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}

class AIChatError extends AIChatState {
  final Failure failure;

  const AIChatError(this.failure);

  @override
  List<Object?> get props => [failure];
} 
