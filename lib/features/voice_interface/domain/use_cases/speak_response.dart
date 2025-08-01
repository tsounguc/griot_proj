import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/voice_interface/domain/repostories/voice_responder_repository.dart';

class SpeakResponse extends UseCaseWithParams<void, String> {
  const SpeakResponse(this.repository);

  final VoiceResponderRepository repository;

  @override
  ResultVoid call(String params) async => repository.speak(params);
}
