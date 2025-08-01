import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/user_input/data/datasources/speech_recognizer.dart';
import 'package:griot_proj/features/user_input/data/datasources/wake_word_listener.dart';
import 'package:griot_proj/features/user_input/domain/repositories/user_input_repository.dart';

class UserInputRepositoryImpl implements UserInputRepository {
  UserInputRepositoryImpl({
    required this.wakeWordListener,
    required this.speechRecognizer,
  });

  final WakeWordListener wakeWordListener;
  final SpeechRecognizer speechRecognizer;

  @override
  ResultVoid listenForWakeWord(Function onWakeWordDetected) async {
    try {
      final result = await wakeWordListener.startListening(onWakeWordDetected);
      return Right(result);
    } on WakeWordException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(WakeWordFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String?> listenToSpeech() async {
    try {
      final result = await speechRecognizer.listenToSpeech();
      return Right(result);
    } on SpeechException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(SpeechFailure.fromException(e));
    }
  }
}
