import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/wake_word/domain/entities/wake_word_event.dart';
import 'package:griot_proj/input/wake_word/domain/repositories/wake_word_repository.dart';

class ListenForWakeWord extends StreamUseCase<WakeWordEvent> {
  const ListenForWakeWord(this.repository);

  final WakeWordRepository repository;

  @override
  ResultStream<WakeWordEvent> call() => repository.listenForWakeWord();
}
