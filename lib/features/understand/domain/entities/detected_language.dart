import 'package:equatable/equatable.dart';

class DetectedLanguage extends Equatable {
  const DetectedLanguage({
    required this.bcp47,
    required this.confidence,
  });

  final String bcp47;
  final double confidence;

  @override
  List<Object?> get props => [bcp47, confidence];
}
