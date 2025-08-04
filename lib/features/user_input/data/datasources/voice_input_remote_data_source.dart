import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:griot_proj/core/errors/exceptions.dart';
import 'package:griot_proj/core/resources/media_resources.dart';
import 'package:griot_proj/core/utils/type_defs.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:porcupine_flutter/porcupine_manager.dart' hide WakeWordCallback;
import 'package:speech_to_text/speech_to_text.dart';

abstract class VoiceInputRemoteDataSource {
  Future<void> listenForWakeWord(WakeWordCallback onWakeWordDetected);

  Future<String?> listenToSpeech();
}

class VoiceInputRemoteDataSourceImpl implements VoiceInputRemoteDataSource {
  VoiceInputRemoteDataSourceImpl({
    required this.speechToText,
  });

  final SpeechToText speechToText;
  late PorcupineManager _manager;

  bool _isListening = false;

  final String accessKey = dotenv.env['PORCUPINE_KEY'] ?? '';

  @override
  Future<void> listenForWakeWord(WakeWordCallback onWakeWordDetected) async {
    try {
      if (_isListening) return;
      _isListening = true;

      _manager = await PorcupineManager.fromKeywordPaths(
        accessKey,
        [MediaResources.heyGRIOT],
        (int keywordIndex) {
          if (keywordIndex == 0) {
            onWakeWordDetected();
          }
        },
        sensitivities: [0.65],
      );

      await _manager.start();
    } on PorcupineException catch (e) {
      throw WakeWordException(
        message: e.message ?? 'Error Occurred',
        statusCode: '505',
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw WakeWordException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }

  @override
  Future<String?> listenToSpeech() async {
    try {
      final available = await speechToText.initialize();

      if (!available) return null;

      var recognizedText = '';
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
    } on SpeechToTextNotInitializedException catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: e.toString(),
      );
      throw SpeechException(
        message: e.toString(),
        statusCode: '505',
      );
    } on ListenNotStartedException catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: e.toString(),
      );
      throw SpeechException(
        message: e.toString(),
        statusCode: '505',
      );
    } on ListenFailedException catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: e.message,
      );
      throw SpeechException(
        message: e.message ?? 'Error Occurred',
        statusCode: '505',
      );
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw SpeechException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
