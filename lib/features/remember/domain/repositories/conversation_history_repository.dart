import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/remember/domain/entities/conversation_log_entry.dart';

abstract class ConversationHistoryRepository {
  ResultVoid logEntry(ConversationLogEntry entry);

  ResultFuture<List<ConversationLogEntry>> getHistory({int limit = 50, int offset = 0});
}
