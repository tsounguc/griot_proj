import 'package:dartz/dartz.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/data/data_sources/context_memory_local_data_source.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';
import 'package:griot_proj/features/model_context/domain/repositories/context_memory_repository.dart';

class ContextMemoryRepositoryImpl implements ContextMemoryRepository {
  ContextMemoryRepositoryImpl(this.localDataSource);

  final ContextMemoryLocalDataSource localDataSource;

  @override
  ResultFuture<List<GriotInteraction>> getRecentInteractions(int limit) async {
    try {
      final interactions = await localDataSource.getRecentInteractions();
      return Right(interactions);
    } on GriotInteractionException catch (e) {
      return Left(GriotInteractionFailure.fromException(e));
    }
  }

  @override
  ResultVoid saveInteraction(GriotInteraction interaction) async {
    try {
      final result = await localDataSource.saveInteraction(interaction);

      return Right(result);
    } on GriotInteractionException catch (e) {
      return Left(GriotInteractionFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String?> getCurrentLanguage() async {
    try {
      final language = await localDataSource.getCurrentLanguage();
      return Right(language);
    } on CurrentLanguageException catch (e) {
      return Left(CurrentLanguageFailure.fromException(e));
    }
  }

  @override
  ResultVoid setCurrentLanguage(String bcp47) async {
    try {
      final result = await localDataSource.setCurrentLanguage(bcp47);
      return Right(result);
    } on CurrentLanguageException catch (e) {
      return Left(CurrentLanguageFailure.fromException(e));
    }
  }
}
