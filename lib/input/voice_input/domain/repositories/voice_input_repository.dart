import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';

abstract class VoiceInputRepository {
  ResultVoid startVoiceInput();

  ResultVoid stopVoiceInput();

  ResultStream<TranscribedInput> listenToVoiceInput();

  ResultVoid dispose();
}
