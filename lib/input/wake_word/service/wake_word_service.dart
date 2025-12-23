
import 'package:griot_proj/input/wake_word/domain/entities/wake_word_event.dart';

abstract class WakeWordService {
  /// Stream of detected wake word events
  Stream<WakeWordEvent> get wakeWordStream;

  /// Start listening to microphone
  Future<void> startListening();

  /// Stop listening
  Future<void> stopListening();

  /// Dispose resources
  Future<void> dispose();
}
