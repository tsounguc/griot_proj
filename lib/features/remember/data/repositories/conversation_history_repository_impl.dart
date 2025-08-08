import 'package:dartz/dartz.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/errors/failures.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/remember/data/data_sources/conversation_history_local_data_source.dart';
import 'package:griot_proj/features/remember/data/models/conversation_log_entry_model.dart';
import 'package:griot_proj/features/remember/domain/entities/conversation_log_entry.dart';
import 'package:griot_proj/features/remember/domain/repositories/conversation_history_repository.dart';

class ConversationHistoryRepositoryImpl implements ConversationHistoryRepository {
  ConversationHistoryRepositoryImpl(this.localDataSource);

  final ConversationHistoryLocalDataSource localDataSource;

  @override
  ResultFuture<List<ConversationLogEntry>> getHistory({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final entries = await localDataSource.getHistory(limit: limit, offset: offset);
      return Right(entries);
    } on ConversationLogException catch (e) {
      return Left(ConversationLogFailure.fromException(e));
    }
  }

  @override
  ResultVoid logEntry(ConversationLogEntry entry) async {
    try {
      final model = ConversationLogEntryModel(
        id: entry.id,
        timestamp: entry.timestamp,
        userInput: entry.userInput,
        griotResponse: entry.griotResponse,
        intent: entry.intent!,
        emotion: entry.emotion!,
        role: entry.role,
        meta: entry.meta,
      );
      final result = await localDataSource.logEntry(model);

      return Right(result);
    } on ConversationLogException catch (e) {
      return Left(ConversationLogFailure.fromException(e));
    }
  }
}
