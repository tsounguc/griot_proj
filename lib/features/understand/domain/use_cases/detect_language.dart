import 'package:griot_proj/core/usecases/usecase.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:griot_proj/features/understand/domain/entities/detected_language.dart';
import 'package:griot_proj/features/understand/domain/repositories/language_repository.dart';

class DetectLanguage extends UseCaseWithParams<DetectedLanguage, String> {
  DetectLanguage(this.repository);
  LanguageRepository repository;
  @override
  ResultFuture<DetectedLanguage> call(
    String params,
  ) => repository.detectFromText(params);
}
