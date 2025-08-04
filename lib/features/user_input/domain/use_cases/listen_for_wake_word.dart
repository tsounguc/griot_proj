import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/user_input/domain/repositories/voice_input_repository.dart';

class ListenForWakeWord extends UseCaseWithParams<void, WakeWordCallback> {
  const ListenForWakeWord(this.repository);

  final VoiceInputRepository repository;

  @override
  ResultFuture<void> call(WakeWordCallback params) => repository.listenForWakeWord(params);
}
