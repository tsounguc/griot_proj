import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/reflect/data/data_sources/reflect_remote_data_source.dart';
import 'package:griot_proj/features/reflect/domain/entities/reflect_answer.dart';
import 'package:griot_proj/features/reflect/domain/repositories/reflect_repository.dart';

class ReflectRepositoryImpl implements ReflectRepository {
  ReflectRepositoryImpl(this.remoteDataSource);

  final ReflectRemoteDataSource remoteDataSource;

  @override
  ResultFuture<ReflectAnswer> getResponse(String prompt) async {
    try {
      final result = await remoteDataSource.getResponse(prompt);

      return Right(result);
    } on GetResponseException catch (e, s) {
      debugPrintStack(label: e.message, stackTrace: s);
      return Left(GetResponseFailure.fromException(e));
    }
  }
}
