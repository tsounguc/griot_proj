import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';
import 'package:griot_proj/input/voice_input/domain/uses_cases/listen_to_voice_input.dart';
import 'package:griot_proj/input/voice_input/domain/uses_cases/start_voice_input.dart';
import 'package:griot_proj/input/voice_input/domain/uses_cases/stop_voice_input.dart';
import 'package:griot_proj/input/voice_input/presentation/cubit/voice_input_state.dart';

class VoiceInputCubit extends Cubit<VoiceInputState> {
  VoiceInputCubit({
    required this.listenToVoiceInput,
    required this.startVoiceInput,
    required this.stopVoiceInput,
  }) : super(VoiceInputInitial());

  final ListenToVoiceInput listenToVoiceInput;
  final StartVoiceInput startVoiceInput;
  final StopVoiceInput stopVoiceInput;

  StreamSubscription<Either<Failure, TranscribedInput>>? _subscription;

  Future<void> startListening() async {
    emit(VoiceInputListening());

    final result = await startVoiceInput();
    result.fold(
      (failure) => emit(VoiceInputError(failure.message)),
      (_) {
        _subscription = listenToVoiceInput().listen(
          (either) => either.fold(
            (failure) => emit(VoiceInputError(failure.message)),
            (input) => emit(VoiceInputTranscribed(input)),
          ),
        );
      },
    );
  }

  Future<void> stopListening() async {
    await _subscription?.cancel();
    final result = await stopVoiceInput();
    result.fold(
      (failure) => emit(VoiceInputError(failure.message)),
      (_) => emit(VoiceInputStopped()),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
