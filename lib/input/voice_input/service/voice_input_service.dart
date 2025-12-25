import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';

abstract class VoiceInputService {
  Stream<TranscribedInput> get transcribedInputStream;

  Future<void> startListening();

  Future<void> stopListening();

  Future<void> dispose();
}
