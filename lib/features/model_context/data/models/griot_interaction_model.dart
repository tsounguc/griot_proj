import 'dart:convert';

import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/model_context/domain/entities/griot_interaction.dart';
import 'package:hive/hive.dart';

part 'griot_interaction_model.g.dart';

@HiveType(typeId: 0)
class GriotInteractionModel extends GriotInteraction {
  const GriotInteractionModel({
    required this.timestamp,
    required this.userInput,
    required this.griotResponse,
  }) : super(
         timestamp: timestamp,
         userInput: userInput,
         griotResponse: griotResponse,
       );

  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final String userInput;

  @HiveField(2)
  final String griotResponse;

  GriotInteractionModel.empty()
    : this(
        timestamp: DateTime.now(),
        userInput: '',
        griotResponse: '',
      );

  factory GriotInteractionModel.fromJson(String source) => GriotInteractionModel.fromMap(
    jsonDecode(source) as DataMap,
  );

  GriotInteractionModel.fromMap(DataMap dataMap)
    : this(
        timestamp: DateTime.parse(dataMap['timestamp'] as String),
        userInput: dataMap['userInput'] as String,
        griotResponse: dataMap['griotResponse'] as String,
      );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
    'timestamp': timestamp.toIso8601String(),
    'userInput': userInput,
    'griotResponse': griotResponse,
  };
}
