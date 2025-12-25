import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';
import 'package:griot_proj/input/voice_input/domain/repositories/voice_input_repository.dart';

class ListenToVoiceInput extends StreamUseCase<TranscribedInput> {
  ListenToVoiceInput(this.repository);

  final VoiceInputRepository repository;

  @override
  ResultStream<TranscribedInput> call() => repository.listenToVoiceInput();
}
