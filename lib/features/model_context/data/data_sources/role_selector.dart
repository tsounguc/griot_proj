abstract class RoleSelector {
  Future<String> selectRole(String intent, String emotion);
}

class RoleSelectorImpl implements RoleSelector {
  @override
  Future<String> selectRole(String intent, String emotion) async {
    if (intent == 'greeting') return 'Greeter';
    if (intent == 'memory_command') return 'Historian';
    if (intent == 'question') return 'Advisor';
    return 'Reflector';
  }
}
