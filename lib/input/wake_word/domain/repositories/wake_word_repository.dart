import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/wake_word/domain/entities/wake_word_event.dart';

abstract class WakeWordRepository {
  /// Starts listening for wake words.
  /// Emits [WakeWordEvent] every time the wake word is detected.\
  ResultStream<WakeWordEvent> listenForWakeWord();

  /// Starts the wake word listener manually, if needed.
  ResultVoid startListening();

  /// Stops the wake word listener manually , if needed.
  ResultVoid stopListening();

  /// Disposes the wake word listener completely.
  ResultVoid dispose();
}
