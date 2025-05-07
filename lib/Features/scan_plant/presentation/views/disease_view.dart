import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazraaty/Core/data/Cubits/User%20Cubit/user_cubit.dart';
import 'package:mazraaty/Core/widgets/dialog_helper.dart';
import 'package:mazraaty/Features/history/presentation/manager/History/history_cubit.dart';
import 'package:mazraaty/Features/scan_plant/data/models/disease_details.dart';
import 'package:mazraaty/Features/scan_plant/presentation/views/widgets/disease_view_body.dart';
import 'package:mazraaty/constants.dart';

class DiseaseView extends StatefulWidget {
  const DiseaseView({
    super.key,
    required this.details,
    required this.imageBytes,
    this.imageUrl,
    this.source = 'scan', // Default source is scan
  });

  final DiseaseDetailsModel details;
  final Uint8List? imageBytes;
  final String? imageUrl;
  final String source; // 'scan' or 'history'

  @override
  State<DiseaseView> createState() => _DiseaseViewState();
}

class _DiseaseViewState extends State<DiseaseView> {
  Timer? _autoSaveTimer;

  @override
  void initState() {
    super.initState();

    // Only set up auto-save timer if this is from a scan (not from history)
    if (widget.source == 'scan') {
      _autoSaveTimer = Timer(const Duration(seconds: 3), () {
        _autoSaveDiseaseToHistory();
      });
    }
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    super.dispose();
  }

  void _autoSaveDiseaseToHistory() {
    if (!mounted) return;

    final userCubit = context.read<UserCubit>();
    final isLoggedIn = userCubit.currentUser != null;

    if (isLoggedIn) {
      // Show saving dialog
      DialogHelper.showAutoSavingDialog(
        context,
        () async {
          await context
              .read<HistoryCubit>()
              .saveDiseaseToHistory(widget.details, widget.imageBytes ?? Uint8List(0));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use provided imageUrl or fallback to disease images if needed
    final String? effectiveImageUrl = widget.imageUrl ??
        (widget.details.diseaseImages.isNotEmpty
            ? '$baseUrl${widget.details.diseaseImages.first.image}'
            : null);

    return SafeArea(
      child: Scaffold(
        body: DiseaseViewBody(
          details: widget.details,
          imageBytes: widget.imageBytes,
          imageUrl: effectiveImageUrl,
          source: widget.source,
        ),
      ),
    );
  }
}
