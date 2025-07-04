import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/constants.dart';

class HomeCommunitySection extends StatelessWidget {
  const HomeCommunitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main container with gradient background
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.indigo.shade50,
                Colors.indigo.shade100,
              ],
              stops: const [0.3, 1.0],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withAlpha(30),
                blurRadius: 12,
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Colors.indigo.withAlpha(40),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Community icon with animated background
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.indigo.withAlpha(40),
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.indigo.withAlpha(30),
                        width: 1,
                      ),
                    ),
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            kMainColor,
                            Colors.indigo.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.people_alt_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Title and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Join Our Community',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade800,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Connect with plant enthusiasts worldwide',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.indigo.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Feature bullets
              _buildFeatureBullet(
                icon: Icons.forum_outlined,
                text: 'Discuss plant care with experts and enthusiasts',
              ),
              const SizedBox(height: 12),
              _buildFeatureBullet(
                icon: Icons.photo_library_outlined,
                text: 'Share photos of your plants and garden',
              ),
              const SizedBox(height: 12),
              _buildFeatureBullet(
                icon: Icons.school_outlined,
                text: 'Access exclusive gardening tutorials and tips',
              ),

              const SizedBox(height: 24),

              // Action buttons
              Row(
                children: [
                  // Visit website button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Open website URL
                      },
                      icon: const Icon(Icons.language, size: 18),
                      label: const Text('Visit Website'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kMainColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Share button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(10),
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {
                        // Share app
                      },
                      icon: const Icon(Icons.share),
                      color: kMainColor,
                      tooltip: 'Share with friends',
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Decorative elements
        Positioned(
          top: -15,
          right: 20,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withAlpha(40),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.eco,
                color: Colors.green.shade400,
                size: 16,
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -10,
          left: 30,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.indigo.withAlpha(40),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.favorite,
                color: Colors.red.shade400,
                size: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build feature bullet points
  Widget _buildFeatureBullet({required IconData icon, required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withAlpha(20),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: kMainColor,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
