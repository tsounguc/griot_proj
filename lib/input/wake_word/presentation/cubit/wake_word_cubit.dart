import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/input/wake_word/domain/entities/wake_word_event.dart';
// import 'package:griot_proj/input/wake_word/domain/use_cases/dispose.dart';
import 'package:griot_proj/input/wake_word/domain/use_cases/listen_for_wake_word.dart';
import 'package:griot_proj/input/wake_word/domain/use_cases/start_wake_word_listening.dart';
import 'package:griot_proj/input/wake_word/domain/use_cases/stop_wake_listening_listening.dart';

part 'wake_word_state.dart';

class WakeWordCubit extends Cubit<WakeWordState> {
  WakeWordCubit({
    required this.listenForWakeWord,
    required this.startWakeWordListening,
    required this.stopWakeListening,
    // required this.dispose,
  }) : super(WakeWordInitial());

  final ListenForWakeWord listenForWakeWord;
  final StartWakeWordListening startWakeWordListening;
  final StopWakeListening stopWakeListening;
  // final Dispose dispose;

  StreamSubscription<Either<Failure, WakeWordEvent>>? _subscription;

  Future<void> startListening() async {
    emit(WakeWordListening());

    final result = await startWakeWordListening();
    result.fold(
      (failure) => emit(WakeWordError(failure.message)),
      (_) {
        _subscription = listenForWakeWord().listen(
          /*onData*/
          (result) {
            result.fold(
              (failure) => emit(WakeWordError(failure.message)),
              (event) => emit(WakeWordDetected(event)),
            );
          },
        );
      },
    );
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    final result = await stopWakeListening();
    result.fold(
      (failure) => emit(WakeWordError(failure.message)),
      (_) => emit(WakeWordInitial()),
    );
  }

  @override
  Future<void> close() async {
    await stop();
    return super.close();
  }
}
