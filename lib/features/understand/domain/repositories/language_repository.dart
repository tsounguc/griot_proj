import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/domain/entities/detected_language.dart';

abstract class LanguageRepository {
  ResultFuture<DetectedLanguage> detectFromText(String text);
}
