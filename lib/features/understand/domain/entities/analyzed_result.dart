import 'package:equatable/equatable.dart';

class AnalyzedResult extends Equatable {
  const AnalyzedResult({
    required this.input,
    required this.intent,
    required this.emotion,
  });

  final String input;
  final String intent;
  final String emotion;

  @override
  List<Object?> get props => [
    input,
    intent,
    emotion,
  ];
}
