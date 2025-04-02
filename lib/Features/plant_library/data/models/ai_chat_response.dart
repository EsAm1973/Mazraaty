class AIChatResponse {
  final String message;
  final bool isUser;
  final DateTime timestamp;

  AIChatResponse({
    required this.message,
    required this.isUser,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory AIChatResponse.fromJson(Map<String, dynamic> json) {
    // Handle OpenRouter API response format
    if (json.containsKey('choices') &&
        json['choices'] is List &&
        json['choices'].isNotEmpty) {
      final choices = json['choices'];
      final choice = choices[0];

      if (choice is Map &&
          choice.containsKey('message') &&
          choice['message'] is Map) {
        final message = choice['message'];
        if (message.containsKey('content')) {
          return AIChatResponse(
            message: message['content']?.toString() ?? 'No response content',
            isUser: false,
          );
        }
      }
    }

    // Fallback for unexpected format
    return AIChatResponse(
      message: 'Could not parse AI response',
      isUser: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isUser': isUser,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
