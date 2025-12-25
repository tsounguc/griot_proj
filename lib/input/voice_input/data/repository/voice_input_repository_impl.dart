import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';
import 'package:griot_proj/input/voice_input/domain/repositories/voice_input_repository.dart';
import 'package:griot_proj/input/voice_input/service/voice_input_service.dart';

class VoiceInputRepositoryImpl implements VoiceInputRepository {
  VoiceInputRepositoryImpl(this.service);

  final VoiceInputService service;

  @override
  ResultStream<TranscribedInput> listenToVoiceInput() {
    return service.transcribedInputStream.transform(
      StreamTransformer<
        TranscribedInput,
        Either<Failure, TranscribedInput>
      >.fromHandlers(
        handleData: (transcribedInput, sink) {
          sink.add(Right(transcribedInput));
        },
        handleError: (error, stackTrace, sink) {
          debugPrint(stackTrace.toString());
          if (error is VoiceInputException) {
            sink.add(Left(VoiceInputFailure.fromException(error)));
          } else {
            sink.add(
              Left(
                VoiceInputFailure(
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
  ResultVoid startVoiceInput() async {
    try {
      final result = await service.startListening();
      return Right(result);
    } on VoiceInputException catch (e) {
      return Left(VoiceInputFailure.fromException(e));
    }
  }

  @override
  ResultVoid stopVoiceInput() async {
    try {
      final result = await service.stopListening();
      return Right(result);
    } on VoiceInputException catch (e) {
      return Left(VoiceInputFailure.fromException(e));
    }
  }

  @override
  ResultVoid dispose() async {
    try {
      final result = await service.dispose();
      return Right(result);
    } on VoiceInputException catch (e) {
      return Left(VoiceInputFailure.fromException(e));
    }
  }
}
