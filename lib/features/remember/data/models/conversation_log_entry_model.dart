import 'dart:convert';

import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/remember/domain/entities/conversation_log_entry.dart';
import 'package:hive/hive.dart';

part 'conversation_log_entry_model.g.dart';

@HiveType(typeId: 2)
class ConversationLogEntryModel extends ConversationLogEntry {
  const ConversationLogEntryModel({
    required this.id,
    required this.timestamp,
    required this.userInput,
    required this.griotResponse,
    required this.intent,
    required this.emotion,
    required this.role,
    required this.meta,
  }) : super(
         id: id,
         timestamp: timestamp,
         userInput: userInput,
         griotResponse: griotResponse,
         intent: intent,
         emotion: emotion,
         role: role,
         meta: meta,
       );

  ConversationLogEntryModel.empty()
    : this(
        id: '',
        timestamp: DateTime.now(),
        userInput: '',
        griotResponse: '',
        intent: '',
        emotion: '',
        role: '',
        meta: {},
      );

  factory ConversationLogEntryModel.fromJson(String source) => ConversationLogEntryModel.fromMap(
    jsonDecode(source) as DataMap,
  );

  ConversationLogEntryModel.fromMap(DataMap dataMap)
    : this(
        id: dataMap['id'] as String,
        timestamp: DateTime.parse(dataMap['timestamp'] as String),
        userInput: dataMap['userInput'] as String,
        griotResponse: dataMap['griotResponse'] as String,
        intent: dataMap['intent'] as String,
        emotion: dataMap['emotion'] as String,
        role: dataMap['role'] as String,
        meta: dataMap['meta'] as DataMap,
      );

  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String userInput;

  @HiveField(3)
  final String griotResponse;

  @HiveField(4)
  final String intent;

  @HiveField(5)
  final String emotion;

  @HiveField(6)
  final String? role;

  @HiveField(7)
  final Map<String, Object?>? meta;
}
