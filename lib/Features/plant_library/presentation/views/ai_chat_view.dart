import 'package:flutter/material.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/ai_chat_view_body.dart';

class AiChatView extends StatelessWidget {
  const AiChatView({super.key, required this.plantName});
  final String plantName;
  @override
  Widget build(BuildContext context) {
    return AiChatViewBody(
      plantName: plantName,
    );
  }
}
