import 'package:equatable/equatable.dart';
import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';

abstract class VoiceInputState extends Equatable {
  const VoiceInputState();

  @override
  List<Object?> get props => [];
}

class VoiceInputInitial extends VoiceInputState {}

class VoiceInputListening extends VoiceInputState {}

class VoiceInputStopped extends VoiceInputState {}

class VoiceInputTranscribed extends VoiceInputState {
  final TranscribedInput transcribedInput;

  const VoiceInputTranscribed(this.transcribedInput);

  @override
  List<Object?> get props => [transcribedInput];
}

class VoiceInputError extends VoiceInputState {
  final String message;

  const VoiceInputError(this.message);

  @override
  List<Object?> get props => [message];
}
