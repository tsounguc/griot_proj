import 'dart:convert';

import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';

class AnalyzedResultModel extends AnalyzedResult {
  AnalyzedResultModel({
    required super.input,
    required super.intent,
    required super.emotion,
  });

  AnalyzedResultModel.empty()
    : this(
        input: '',
        intent: '',
        emotion: '',
      );

  factory AnalyzedResultModel.fromJson(String source) => AnalyzedResultModel.fromMap(
    jsonDecode(source) as DataMap,
  );

  AnalyzedResultModel.fromMap(DataMap dataMap)
    : this(
        input: dataMap['input'] as String,
        intent: dataMap['intent'] as String,
        emotion: dataMap['emotion'] as String,
      );

  String toJson() => jsonEncode(toMap());

  DataMap toMap() => {
    'input': input,
    'intent': intent,
    'emotion': emotion,
  };
}
