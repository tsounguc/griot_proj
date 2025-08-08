import 'package:hive/hive.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/features/remember/data/models/conversation_log_entry_model.dart';

abstract class ConversationHistoryLocalDataSource {
  Future<void> logEntry(ConversationLogEntryModel entry);
  Future<List<ConversationLogEntryModel>> getHistory({int limit = 50, int offset = 0});
}

class ConversationHistoryLocalDataSourceImpl implements ConversationHistoryLocalDataSource {
  ConversationHistoryLocalDataSourceImpl(this._box);
  final Box<ConversationLogEntryModel> _box;

  static const String boxName = 'conversation_history';

  @override
  Future<void> logEntry(ConversationLogEntryModel entry) async {
    try {
      await _box.add(entry);
    } catch (e) {
      throw const ConversationLogException(message: 'Failed to log conversation', statusCode: 'CACHE_WRITE');
    }
  }

  @override
  Future<List<ConversationLogEntryModel>> getHistory({int limit = 50, int offset = 0}) async {
    try {
      // newest first
      final all = _box.values.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp));

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
