import 'package:griot_proj/core/utils/type_defs.dart';

abstract class VoiceResponderRepository {
  ResultVoid speak({
    required String message,
    required String currentLanguage,
  });
}
