import 'package:flutter/cupertino.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/features/understand/data/models/analyzed_result_model.dart';
import 'package:griot_proj/features/understand/domain/entities/analyzed_result.dart';

abstract class UnderstandRemoteDataSource {
  Future<AnalyzedResult> analyzed(String input);
}

class UnderstandRemoteDataSourceImpl implements UnderstandRemoteDataSource {
  @override
  Future<AnalyzedResultModel> analyzed(String input) async {
    try {
      // TODO(Basic-logic): replace with ML/NLP or service later
      final intent = _detectIntent(input);
      final emotion = _detectEmotion(input);

      final result = AnalyzedResultModel(
        input: input,
        intent: intent,
        emotion: emotion,
      );
      return result;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw AnalyzeException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  String _detectIntent(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('how are you') || lower.contains('hello')) return 'greeting';
    if (lower.contains('remember')) return 'memory_command';
    if (lower.contains('tell me') || lower.contains('what is')) return 'question';
    return 'unknown';
  }

  String _detectEmotion(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('sad') || lower.contains('tired')) return 'sad';
    if (lower.contains('happy') || lower.contains('excited')) return 'happy';
    return 'neutral';
  }
}
