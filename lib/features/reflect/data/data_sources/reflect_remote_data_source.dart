import 'package:flutter/cupertino.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/utils/prompt_builder.dart';

abstract class ReflectRemoteDataSource {
  Future<String> getResponse(String prompt);
}

class ReflectRemoteDataSourceImpl implements ReflectRemoteDataSource {
  @override
  Future<String> getResponse(String prompt) async {
    try {
      // TODO(Reflect-Remote-Data-Source): For now  simulate GPT response
      // Replace with OpenAI API call later
      await Future<void>.delayed(const Duration(milliseconds: 500));
      return 'This is a GPT-like response to: "$prompt"';
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw GetResponseException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
