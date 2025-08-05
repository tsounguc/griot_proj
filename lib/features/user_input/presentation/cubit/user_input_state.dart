part of 'user_input_cubit.dart';

sealed class UserInputState extends Equatable {
  const UserInputState();

  @override
  List<Object> get props => [];
}

final class WakeWordInitial extends UserInputState {}

class WakeWordListening extends UserInputState {
  const WakeWordListening();
}

class WakeWordHeard extends UserInputState {
  const WakeWordHeard();
}

class WaitingForUserInput extends UserInputState {
  const WaitingForUserInput();
}

class UserVoiceInputCaptured extends UserInputState {
  const UserVoiceInputCaptured(this.text);
  final String text;

  @override
  List<Object> get props => [text];
}

class UserVoiceInputAnalyzed extends UserInputState {
  const UserVoiceInputAnalyzed(this.result);
  final AnalyzedResult result;

  @override
  List<Object> get props => [result];
}

class GRIOTResponseReceived extends UserInputState {
  const GRIOTResponseReceived(this.text);
  final String text;

  @override
  List<Object> get props => [text];
}

class UserInputError extends UserInputState {
  const UserInputError(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
