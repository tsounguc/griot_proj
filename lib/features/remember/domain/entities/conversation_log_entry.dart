import 'package:equatable/equatable.dart';

class ConversationLogEntry extends Equatable {
  const ConversationLogEntry({
    required this.id,
    required this.timestamp,
    required this.userInput,
    required this.griotResponse,
    required this.intent,
    required this.emotion,
    required this.role,
    required this.meta,
  });

  final String id;
  final DateTime timestamp;
  final String userInput;
  final String griotResponse;

  /// Optional annotations for earlier stages in the pipeline
  final String? intent;
  final String? emotion;
  final String? role;

  /// Optional bag for future fields without schema churn.
  /// e.g {'model':'gpt-4o-mini', 'promptToken': 180, 'latencyMs': 520}
  final Map<String, Object?>? meta;

  @override
  List<Object?> get props => [
    id,
    timestamp,
    userInput,
    griotResponse,
    intent,
    emotion,
    role,
    meta,
  ];
}
