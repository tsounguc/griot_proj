part of 'wake_word_cubit.dart';

sealed class WakeWordState extends Equatable {
  const WakeWordState();

  @override
  List<Object?> get props => [];
}

class WakeWordInitial extends WakeWordState {}

class WakeWordListening extends WakeWordState {}

class WakeWordDetected extends WakeWordState {
  const WakeWordDetected(this.event);

  final WakeWordEvent event;

  @override
  List<Object?> get props => [event];
}

class WakeWordError extends WakeWordState {
  const WakeWordError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
