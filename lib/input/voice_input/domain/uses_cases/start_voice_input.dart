import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/voice_input/domain/repositories/voice_input_repository.dart';

class StartVoiceInput extends UseCase<void> {
  StartVoiceInput(this.repository);

  final VoiceInputRepository repository;

  @override
  ResultFuture<void> call() => repository.startVoiceInput();
}
