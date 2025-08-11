import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/data/data_sources/language_remote_data_source.dart';
import 'package:griot_proj/features/understand/domain/entities/detected_language.dart';
import 'package:griot_proj/features/understand/domain/repositories/language_repository.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  LanguageRepositoryImpl(this.remoteDataSource);

  final LanguageRemoteDataSource remoteDataSource;
  @override
  ResultFuture<DetectedLanguage> detectFromText(String text) async {
    try {
      final result = await remoteDataSource.detectFromText(text);
      return Right(result);
    } on DetectedLanguageException catch (e, s) {
      debugPrintStack(stackTrace: s, label: e.message);
      return Left(DetectedLanguageFailure.fromException(e));
    }
  }
}
