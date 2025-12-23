import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/wake_word/domain/entities/wake_word_event.dart';
import 'package:griot_proj/input/wake_word/domain/repositories/wake_word_repository.dart';
import 'package:griot_proj/input/wake_word/service/wake_word_service.dart';

class WakeWordRepositoryImpl implements WakeWordRepository {
  WakeWordRepositoryImpl(this._wakeWordService);
  final WakeWordService _wakeWordService;

  @override
  ResultStream<WakeWordEvent> listenForWakeWord() {
    return _wakeWordService.wakeWordStream.transform(
      StreamTransformer<
        WakeWordEvent,
        Either<Failure, WakeWordEvent>
      >.fromHandlers(
        handleData: (wakeWordEvent, sink) {
          sink.add(Right(wakeWordEvent));
        },
        handleError: (error, stackTrace, sink) {
          debugPrint(stackTrace.toString());
          if (error is WakeWordException) {
            sink.add(Left(WakeWordFailure.fromException(error)));
          } else {
            sink.add(
              Left(
                WakeWordFailure(
                  message: error.toString(),
                  statusCode: 505,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  ResultVoid startListening() async {
    try {
      final result = await _wakeWordService.startListening();
      return Right(result);
    } on WakeWordException catch (e) {
      return Left(WakeWordFailure.fromException(e));
    }
  }

  @override
  ResultVoid stopListening() async {
    try {
      final result = await _wakeWordService.stopListening();
      return Right(result);
    } on WakeWordException catch (e) {
      return Left(WakeWordFailure.fromException(e));
    }
  }

  @override
  ResultVoid dispose() async {
    try {
      final result = await _wakeWordService.dispose();
      return Right(result);
    } on WakeWordException catch (e) {
      return Left(WakeWordFailure.fromException(e));
    }
  }
}
