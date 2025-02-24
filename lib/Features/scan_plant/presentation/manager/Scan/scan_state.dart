import 'dart:typed_data';

class ScanState {
  final Uint8List? imageBytes;
  final String prediction;
  final bool isLoading;
  final String error;

  const ScanState({
    this.imageBytes,
    this.prediction = '',
    this.isLoading = false,
    this.error = '',
  });

  ScanState copyWith({
    Uint8List? imageBytes,
    String? prediction,
    bool? isLoading,
    String? error,
  }) {
    return ScanState(
      imageBytes: imageBytes ?? this.imageBytes,
      prediction: prediction ?? this.prediction,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? '',
    );
  }
}
