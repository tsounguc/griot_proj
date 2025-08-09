import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/features/reflect/data/models/reflect_answer_model.dart';
import 'package:http/http.dart' as http;

abstract class ReflectRemoteDataSource {
  Future<ReflectAnswerModel> getResponse(String prompt);
}

class ReflectRemoteDataSourceImpl implements ReflectRemoteDataSource {
  final openAIUrl = 'https://api.openai.com/v1/chat/completions';
  final String openAIApiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  @override
  Future<ReflectAnswerModel> getResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(openAIUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIApiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are GRIOT, a clear and grounded AI assistant. '
                  'When a user speaks, respond concisely with helpful, '
                  'thoughtful insight - avoiding fluff, excessive emotion, '
                  'or poetic language unless needed. Keep it under 3 sentences '
                  'unless needed.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.3,
          'max_tokens': 250,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['choices'][0]['message']['content'];
        final text = message.toString().trim();
        final meta = <String, dynamic>{
          'model': data['model'],
          'prompt_tokens': data['usage']?['prompt_tokens'],
          'completion_tokens': data['usage']?['completion_tokens'],
          'total_tokens': data['usage']?['total_tokens'],
        };
        return ReflectAnswerModel(text: text, meta: meta);
      } else {
        throw GetResponseException(
          message: 'OpenAI API failed: ${response.statusCode} ${response.reasonPhrase}',
          statusCode: response.statusCode.toString(),
        );
      }
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw GetResponseException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
