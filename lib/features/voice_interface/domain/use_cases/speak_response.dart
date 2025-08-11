import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/voice_interface/domain/repostories/voice_responder_repository.dart';

class SpeakResponse extends UseCaseWithParams<void, SpeakResponseParams> {
  const SpeakResponse(this.repository);

  final VoiceResponderRepository repository;

  @override
  ResultVoid call(SpeakResponseParams params) async => repository.speak(
    message: params.text,
    currentLanguage: params.currentLanguage,
  );
}

class SpeakResponseParams extends Equatable {
  const SpeakResponseParams({
    required this.text,
    required this.currentLanguage,
  });

  final String text;
  final String currentLanguage;
  @override
  List<Object?> get props => [];
}
