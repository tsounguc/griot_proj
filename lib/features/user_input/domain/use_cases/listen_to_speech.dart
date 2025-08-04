import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/user_input/domain/repositories/voice_input_repository.dart';

class ListenToSpeech extends UseCase<String?> {
  const ListenToSpeech(this.repository);
  final VoiceInputRepository repository;

  @override
  ResultFuture<String?> call() => repository.listenToSpeech();
}
