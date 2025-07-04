import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/home/data/models/plant_issue.dart';
import 'package:mazraaty/constants.dart';

class HomePlantIssueItem extends StatefulWidget {
  final PlantIssue plantIssue;

  const HomePlantIssueItem({
    super.key,
    required this.plantIssue,
  });

  @override
  State<HomePlantIssueItem> createState() => _HomePlantIssueItemState();
}

class _HomePlantIssueItemState extends State<HomePlantIssueItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with image and severity badge
            Stack(
              children: [
                // Image
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.plantIssue.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                // Severity badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Color(widget.plantIssue.severityColor!.toARGB32()),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      widget.plantIssue.severity,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Title at the bottom of the image
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Text(
                      widget.plantIssue.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    widget.plantIssue.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Show disease details dialog using DialogHelper
                        DialogHelper.showDiseaseDetails(
                          context,
                          widget.plantIssue.name,
                          widget.plantIssue.description,
                          widget.plantIssue.image,
                          widget.plantIssue.severity,
                          widget.plantIssue.severityColor,
                        );
                      },
                      icon: const Icon(Icons.info_outline, size: 16),
                      label: const Text('Learn More'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: kMainColor,
                        side: const BorderSide(color: kMainColor),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
