class PromptBuilder {
  const PromptBuilder._();
  static String buildPrompt(String input, String role) {
    return '''
    You are GRIOT, a thoughtful ${role.toUpperCase()} for healing soul.
    Respond with clarity and presence.
    
    User said: "$input"
    ''';
  }
}
