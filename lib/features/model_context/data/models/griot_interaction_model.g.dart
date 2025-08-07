// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'griot_interaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GriotInteractionModelAdapter extends TypeAdapter<GriotInteractionModel> {
  @override
  final int typeId = 0;

  @override
  GriotInteractionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GriotInteractionModel(
      timestamp: fields[0] as DateTime,
      userInput: fields[1] as String,
      griotResponse: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GriotInteractionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.userInput)
      ..writeByte(2)
      ..write(obj.griotResponse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GriotInteractionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
