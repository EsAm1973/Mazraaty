import 'dart:typed_data';

class ScanState {
  final Uint8List? imageBytes;
  final String diseaseName; // اسم المرض منفصل
  final double confidence; // النسبة المئوية منفصلة
  final bool isLoading;
  final String error;

  const ScanState({
    this.imageBytes,
    this.diseaseName = '',
    this.confidence = 0.0,
    this.isLoading = false,
    this.error = '',
  });

  //دالة تُستخدم لإنشاء نسخة جديدة من الحالة مع إمكانية تعديل بعض المتغيرات دون الحاجة لإعادة إنشاء الكائن بالكامل.
  ScanState copyWith({
    Uint8List? imageBytes,
    String? diseaseName,
    double? confidence,
    bool? isLoading,
    String? error,
  }) {
    return ScanState(
      imageBytes: imageBytes ?? this.imageBytes,
      diseaseName: diseaseName ?? this.diseaseName,
      confidence: confidence ?? this.confidence,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error, // تم التصحيح هنا
    );
  }
}