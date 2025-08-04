import 'package:griot_proj/core/utils/type_defs.dart';

abstract class VoiceInputRepository {
  /// Starts wake word detection and invokes the callback when triggered.
  ResultVoid listenForWakeWord(WakeWordCallback onWakeWordDetected);

  /// Listens to user's voice and returns a transcribed Strings,
  /// or null if failed.
  ResultFuture<String?> listenToSpeech();
}
