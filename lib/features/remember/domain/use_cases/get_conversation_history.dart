import 'package:equatable/equatable.dart';
import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/remember/domain/entities/conversation_log_entry.dart';
import 'package:griot_proj/features/remember/domain/repositories/conversation_history_repository.dart';

class GetConversationHistory extends UseCaseWithParams<List<ConversationLogEntry>, GetConversationHistoryParams> {
  GetConversationHistory(this.repository);

  final ConversationHistoryRepository repository;

  @override
  ResultFuture<List<ConversationLogEntry>> call(
    GetConversationHistoryParams params,
  ) => repository.getHistory(limit: params.limit, offset: params.offset);
}

class GetConversationHistoryParams extends Equatable {
  const GetConversationHistoryParams({
    this.limit = 50,
    this.offset = 0,
  });

  final int limit;
  final int offset;

  @override
  List<Object?> get props => [limit, offset];
}
