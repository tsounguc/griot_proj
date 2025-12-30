import 'package:equatable/equatable.dart';
import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';

sealed class VoiceInputState extends Equatable {
  const VoiceInputState();

  @override
  List<Object?> get props => [];
}

class VoiceInputInitial extends VoiceInputState {}

class VoiceInputListening extends VoiceInputState {}

class VoiceInputStopped extends VoiceInputState {}

class VoiceInputTranscribed extends VoiceInputState {
  const VoiceInputTranscribed(this.transcribedInput);

  final TranscribedInput transcribedInput;

  @override
  List<Object?> get props => [transcribedInput];
}

class VoiceInputError extends VoiceInputState {
  const VoiceInputError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
