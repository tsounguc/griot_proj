import 'package:griot_proj/features/model_context/data/models/griot_interaction_model.dart';
import 'package:griot_proj/features/remember/domain/entities/conversation_log_entry.dart';
import 'package:hive/hive.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/features/remember/data/models/conversation_log_entry_model.dart';

abstract class ConversationHistoryLocalDataSource {
  Future<void> logEntry(ConversationLogEntry entry);
  Future<List<ConversationLogEntryModel>> getHistory({int limit = 50, int offset = 0});
}

class ConversationHistoryLocalDataSourceImpl implements ConversationHistoryLocalDataSource {
  ConversationHistoryLocalDataSourceImpl();

  static const String boxName = 'conversation_history';

  @override
  Future<void> logEntry(ConversationLogEntry entry) async {
    try {
      final _box = await Hive.openBox<ConversationLogEntryModel>(boxName);
      final entryModel = ConversationLogEntryModel(
        id: entry.id,
        timestamp: entry.timestamp,
        userInput: entry.userInput,
        griotResponse: entry.griotResponse,
        intent: entry.intent ?? '',
        emotion: entry.emotion ?? '',
        role: entry.role,
        meta: entry.meta,
      );
      await _box.add(entryModel);
    } catch (e) {
      throw const ConversationLogException(
        message: 'Failed to log conversation',
        statusCode: 'CACHE_WRITE',
      );
    }
  }

  @override
  Future<List<ConversationLogEntryModel>> getHistory({int limit = 50, int offset = 0}) async {
    try {
      final box = await Hive.openBox<ConversationLogEntryModel>(boxName);

      // newest first
      final all = box.values.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));

      final start = offset.clamp(0, all.length);
      final end = (offset + limit).clamp(0, all.length);
      return all.sublist(start, end);
    } catch (e) {
      throw const ConversationLogException(
        message: 'Failed to read conversation history',
        statusCode: 'CACHE_READ',
      );
    }
  }
}
