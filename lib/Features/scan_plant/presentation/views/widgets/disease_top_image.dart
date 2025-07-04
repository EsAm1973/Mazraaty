import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DiseaseTopImage extends StatelessWidget {
  const DiseaseTopImage({
    super.key,
    required this.image,
    required this.disease,
    this.imageUrl,
    this.source = 'scan', // Default is scan
  });

  final Uint8List image;
  final DiseaseDetailsModel disease;
  final String? imageUrl;
  final String source; // 'scan' or 'history'

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        // Close any existing dialog first
        if (state is HistorySaveSuccess || state is HistorySaveError) {
          // Close the loading dialog if it's open
          Navigator.of(context).popUntil((route) => route.isFirst || route.settings.name != null);

          // Then show the appropriate response dialog
          if (state is HistorySaveSuccess) {
            DialogHelper.showSaveResponse(context, state.message);
          } else if (state is HistorySaveError) {
            DialogHelper.showError(context, 'Error', state.errorMessage);
          }
        }
      },
      builder: (context, state) {
        // No need to check login status anymore since saving is automatic

        return Stack(
          children: [
            // If we have an image from the camera/gallery that's not empty, use it first
            image.isNotEmpty
            ? Image.memory(
                image,
                width: double.infinity,
                height: 350,
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return _buildNetworkImageFallback();
                },
              )
            // Otherwise try to use the network image URL if available
            : _buildNetworkImageFallback(),
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withAlpha(179), // Equivalent to opacity 0.7
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            // Removed manual save button as saving is now automatic
          ],
        );
      },
    );
  }

  Widget _buildNetworkImageFallback() {
    // Check if we have a direct image URL passed from history
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        width: double.infinity,
        height: 350,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
          width: double.infinity,
          height: 350,
          color: Colors.grey.shade200,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => _buildDiseaseFallbackImage(),
      );
    }
    // Otherwise try to use a disease sample image
    return _buildDiseaseFallbackImage();
  }

  Widget _buildDiseaseFallbackImage() {
    if (disease.diseaseImages.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: '$baseUrl${disease.diseaseImages.first.image}',
        width: double.infinity,
        height: 350,
        fit: BoxFit.fill,
        placeholder: (context, url) => Container(
          width: double.infinity,
          height: 350,
          color: Colors.grey.shade200,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: double.infinity,
          height: 350,
          color: Colors.grey.shade300,
          child: const Center(
            child: Text('Image not available'),
          ),
        ),
      );
    }

    // Final fallback if no images are available
    return Container(
      width: double.infinity,
      height: 350,
      color: Colors.grey.shade300,
      child: const Center(
        child: Text('Image not available'),
      ),
    );
  }
}
