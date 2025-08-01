import 'package:griot_proj/core/utils/type_defs.dart';

abstract class VoiceResponderRepository {
  ResultVoid speak(String message);
}
