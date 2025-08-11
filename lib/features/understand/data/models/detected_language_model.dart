import 'dart:convert';

import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/domain/entities/detected_language.dart';

class DetectedLanguageModel extends DetectedLanguage {
  const DetectedLanguageModel({
    required super.bcp47,
    required super.confidence,
  });

  const DetectedLanguageModel.empty(): this(bcp47: '', confidence: 0);

  factory DetectedLanguageModel.fromJson(String source) => DetectedLanguageModel.fromMap(jsonDecode(source) as DataMap,);

  DetectedLanguageModel.fromMap(DataMap dataMap): this(bcp47: dataMap['bcp47'] as String, confidence: dataMap['confidence'] as double)

}
