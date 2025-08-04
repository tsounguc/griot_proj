import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/data/data_sources/understand_remote_data_source.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';
import 'package:griot_proj/features/understand/domain/repositories/understand_repository.dart';

class UnderstandRepositoryImpl extends UnderstandRepository {
  UnderstandRepositoryImpl({required this.remoteDataSource});

  final UnderstandRemoteDataSource remoteDataSource;

  @override
  ResultFuture<AnalyzedResult> analyze(String input) async {
    try {
      final result = await remoteDataSource.analyzed(input);

      return Right(result);
    } on AnalyzeException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(AnalyzeFailure.fromException(e));
    }
  }
}
