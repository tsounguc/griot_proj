import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/voice_interface/data/datasource/voice_responder.dart';
import 'package:griot_proj/features/voice_interface/domain/repostories/voice_responder_repository.dart';

class VoiceResponderRepositoryImpl implements VoiceResponderRepository {
  const VoiceResponderRepositoryImpl(this.voiceResponder);

  final VoiceResponder voiceResponder;

  @override
  ResultVoid speak({
    required String message,
    required String currentLanguage,
  }) async {
    try {
      final result = await voiceResponder.speak(
        message: message,
        currentLanguage: currentLanguage,
      );
      return Right(result);
    } on SpeakResponseException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(SpeakResponseFailure.fromException(e));
    }
  }
}
