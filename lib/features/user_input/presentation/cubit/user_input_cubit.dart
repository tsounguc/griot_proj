import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/features/user_input/domain/use_cases/listen_for_wake_word.dart';
import 'package:griot_proj/features/user_input/domain/use_cases/listen_to_speech.dart';
import 'package:griot_proj/features/voice_interface/domain/use_cases/speak_response.dart';

part 'user_input_state.dart';

class WakeWordCubit extends Cubit<UserInputState> {
  WakeWordCubit({
    required ListenForWakeWord listenForWakeWord,
    required SpeakResponse speakResponse,
    required ListenToSpeech listenToSpeech,
  }) : _listenForWakeWord = listenForWakeWord,
       _speakResponse = speakResponse,
       _listenToUserSpeech = listenToSpeech,
       super(WakeWordInitial());

  final ListenForWakeWord _listenForWakeWord;
  final SpeakResponse _speakResponse;
  final ListenToSpeech _listenToUserSpeech;

  Future<void> listenForWakeWord() async {
    emit(const WakeWordListening());

    final result = await _listenForWakeWord.call(
      _onWakeWordHeard,
    );

    result.fold(
      (failure) => emit(UserInputError(failure.message)),
      (_) => null, // already handled by callback
    );
  }

  Future<void> listenToUserSpeech() async {
    final result = await _listenToUserSpeech();
    result.fold(
      (failure) => emit(UserInputError(failure.message)),
      (input) {
        if (input == null || input.trim().isEmpty) {
          emit(const UserInputError("Didn't catch that. Please try again."));
        } else {
          emit(UserVoiceInputCaptured(input));
        }
      },
    );
  }

  dynamic _onWakeWordHeard() async {
    emit(const WakeWordHeard());
    final result = await _speakResponse.call('Yes? How can I help you?');

    result.fold(
      (failure) => emit(UserInputError(failure.message)),
      (_) {
        emit(const WaitingForUserInput());
      },
    );
  }
}
