import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/wake_word/domain/repositories/wake_word_repository.dart';

class StopWakeListening extends UseCase<void>{
  const StopWakeListening(this.repository);

  final WakeWordRepository repository;

  @override
  ResultFuture<void> call() => repository.stopListening();

}