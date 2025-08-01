import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:griot_proj/core/resources/media_resources.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';

abstract class WakeWordListener {
  Future<void> startListening(Function onWakeWordDetected);
  Future<void> stopListening();
  Future<void> dispose();
}

class WakeWordListenerImpl implements WakeWordListener {
  late PorcupineManager _manager;
  bool _isListening = false;

  final String accessKey = dotenv.env['PORCUPINE_KEY'] ?? '';

  @override
  Future<void> startListening(Function onWakeWordDetected) async {
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
  }

  @override
  Future<void> stopListening() async {
    _isListening = false;
    await _manager.stop();
  }

  @override
  Future<void> dispose() async {
    await _manager.delete();
  }
}
