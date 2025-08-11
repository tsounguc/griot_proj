import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';

class PromptBuilder {
  const PromptBuilder._();
  static String buildPrompt({
    required String input,
    required String role,
    required String languageCode,
    List<GriotInteraction> recent = const [],
  }) {
    final history = _formatHistory(recent);

    return '''
    Role: $role
    Reply in the user's language: $languageCode
    Style: clear, practical, under 2-3 sentences. avoid poetic/overly emotional language.
    ${history.isEmpty ? '' : 'Recent context (most recent first): \n$history\n'}
    User said: "$input"
    
    Guidelines:
    - If the request is ambiguous, ask one brief clarifying question.
    - Be helpful and specific; avoid generic platitudes.
    ''';
  }

  static String _formatHistory(List<GriotInteraction> recent) {
    if (recent.isEmpty) return '';

    // Most recent first (assume use case already returns latest first;
    // if not reverse here).
    final lines = recent
        .take(3)
        .map((it) {
          final user = it.userInput.trim().replaceAll('\n', ' ');
          final ai = it.griotResponse.trim().replaceAll('\n', ' ');
          return '- User: "$user"\n GRIOT: "$ai"';
        })
        .join('\n');

    return lines;
  }
}
