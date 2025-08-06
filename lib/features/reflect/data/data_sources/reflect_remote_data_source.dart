import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/utils/prompt_builder.dart';
import 'package:http/http.dart' as http;

abstract class ReflectRemoteDataSource {
  Future<String> getResponse(String prompt);
}

class ReflectRemoteDataSourceImpl implements ReflectRemoteDataSource {
  final openAIUrl = 'https://api.openai.com/v1/chat/completions';
  final String openAIApiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
  @override
  Future<String> getResponse(String prompt) async {
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
                  'You are GRIOT, a wise assistant who responds to each user'
                  ' message with insight, presence, and a healing tone.',
            },
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'temperature': 0.7,
          'max_token': 250,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final message = data['choices'][0]['message']['content'];
        return message.toString().trim();
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
