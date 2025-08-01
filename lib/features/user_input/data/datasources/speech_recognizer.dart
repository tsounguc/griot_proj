import 'package:speech_to_text/speech_to_text.dart';

abstract class SpeechRecognizer {
  Future<String?> listenToSpeech();
}

class SpeechRecognizerImpl implements SpeechRecognizer {
  SpeechRecognizerImpl(this.speechToText);

  final SpeechToText speechToText;

  @override
  Future<String?> listenToSpeech() async {
    bool available = await speechToText.initialize();

    if (!available) return null;

    String recognizedText = '';
    await speechToText.listen(
      onResult: (result) {
        recognizedText = result.recognizedWords;
      },
      listenFor: const Duration(seconds: 5),
      pauseFor: const Duration(seconds: 2),
      localeId: 'en_US',
    );
    await Future<void>.delayed(const Duration(seconds: 6));
    await speechToText.stop();

    return recognizedText.isNotEmpty ? recognizedText : null;
  }
}
