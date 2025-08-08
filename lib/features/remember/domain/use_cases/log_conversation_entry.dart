import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/remember/domain/entities/conversation_log_entry.dart';
import 'package:griot_proj/features/remember/domain/repositories/conversation_history_repository.dart';

class LogConversationEntry extends UseCaseWithParams<void, ConversationLogEntry> {
  LogConversationEntry(this.repository);

  final ConversationHistoryRepository repository;

  @override
  ResultVoid call(ConversationLogEntry params) => repository.logEntry(params);
}
