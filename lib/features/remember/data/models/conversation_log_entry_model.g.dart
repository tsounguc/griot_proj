// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_log_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConversationLogEntryModelAdapter
    extends TypeAdapter<ConversationLogEntryModel> {
  @override
  final int typeId = 2;

  @override
  ConversationLogEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ConversationLogEntryModel(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      userInput: fields[2] as String,
      griotResponse: fields[3] as String,
      intent: fields[4] as String,
      emotion: fields[5] as String,
      role: fields[6] as String?,
      meta: (fields[7] as Map?)?.cast<String, Object?>(),
    );
  }

  @override
  void write(BinaryWriter writer, ConversationLogEntryModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.userInput)
      ..writeByte(3)
      ..write(obj.griotResponse)
      ..writeByte(4)
      ..write(obj.intent)
      ..writeByte(5)
      ..write(obj.emotion)
      ..writeByte(6)
      ..write(obj.role)
      ..writeByte(7)
      ..write(obj.meta);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversationLogEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
