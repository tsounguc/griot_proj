import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/user_input/data/datasources/voice_input_remote_data_source.dart';
import 'package:griot_proj/features/user_input/domain/repositories/voice_input_repository.dart';

class VoiceInputRepositoryImpl implements VoiceInputRepository {
  VoiceInputRepositoryImpl({required this.remoteDataSource});

  final VoiceInputRemoteDataSource remoteDataSource;

  @override
  ResultVoid listenForWakeWord(WakeWordCallback onWakeWordDetected) async {
    try {
      final result = await remoteDataSource.listenForWakeWord(onWakeWordDetected);
      return Right(result);
    } on WakeWordException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(WakeWordFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String?> listenToSpeech() async {
    try {
      final result = await remoteDataSource.listenToSpeech();
      return Right(result);
    } on SpeechException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(SpeechFailure.fromException(e));
    }
  }
}
