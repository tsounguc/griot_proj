import 'package:griot_proj/features/understand/domain/entities/detected_language.dart';

abstract class LanguageRemoteDataSource {
  Future<DetectedLanguageModel> detectFromText(String text)
}