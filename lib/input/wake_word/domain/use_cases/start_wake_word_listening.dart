import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/wake_word/domain/repositories/wake_word_repository.dart';

class StartWakeWordListening extends UseCase<void>{
  const StartWakeWordListening(this.repository);

  final WakeWordRepository repository;

  @override
  ResultFuture<void> call() => repository.startListening();
}