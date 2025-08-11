import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/features/understand/data/models/detected_language_model.dart';

abstract class LanguageRemoteDataSource {
  Future<DetectedLanguageModel> detectFromText(String text);
}

class LanguageRemoteDataSourceImpl implements LanguageRemoteDataSource {
  const LanguageRemoteDataSourceImpl(this.identifier);

  final LanguageIdentifier identifier;

  // final identifier = LanguageIdentifier(confidenceThreshold: 0.4);

  @override
  Future<DetectedLanguageModel> detectFromText(String text) async {
    try {
      final langCode = await identifier.identifyLanguage(text);
      return DetectedLanguageModel(
        bcp47: langCode,
        confidence: 0.9,
      );
    } catch (e) {
      throw DetectedLanguageException(
        message: e.toString(),
        statusCode: 'LANG_DETECT',
      );
    }
  }
}
