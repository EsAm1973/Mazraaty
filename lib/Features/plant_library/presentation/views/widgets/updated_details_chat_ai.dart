import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/widgets/custom_button.dart';
import 'package:mazraaty/Features/plant_library/presentation/views/widgets/ai_chat_view_body.dart';

class PlantHealthCard extends StatelessWidget {
  final bool isHealthy;
  final String message;
  final String description;
  final VoidCallback onChatPressed;
  final String plantName;

  const PlantHealthCard({
    super.key,
    this.isHealthy = true,
    this.message = 'HORRAY! YOUR PLANT LOOKS HEALTHY!',
    this.description =
        'The plant was diagnosed automatically.\nContact our botany exerts to be sure about results',
    required this.onChatPressed,
    required this.plantName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFE8F5EC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/plant-02.png',
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 8),
                Text(
                  'Plant Health',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Beta',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: GoogleFonts.montserrat(
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                onPressed: () {
                  // Open the AI Chat Screen directly with plant name
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AiChatViewBody(
                        plantName: plantName,
                      ),
                    ),
                  );
                },
                text: 'Chat with AI',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
