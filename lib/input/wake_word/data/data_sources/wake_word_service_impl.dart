import 'dart:async';

import 'package:griot_proj/input/wake_word/domain/entities/wake_word_event.dart';
import 'package:griot_proj/input/wake_word/service/wake_word_service.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

class WakeWordServiceImpl implements WakeWordService {
  WakeWordServiceImpl(this.voskFlutterPlugin);

  final VoskFlutterPlugin voskFlutterPlugin;

  final _controller = StreamController<WakeWordEvent>.broadcast();

  late Model _model;
  SpeechService? _speechService;

  bool _initialized = false;

  @override
  Stream<WakeWordEvent> get wakeWordStream => _controller.stream;

  @override
  Future<void> startListening() async {
    if (!_initialized) await _init();
    await _speechService?.start();
  }

  @override
  Future<void> stopListening() async {
    await _speechService?.stop();
  }

  @override
  Future<void> dispose() async {
    await _speechService?.stop();
    await _controller.close();
    _initialized = false;
  }

  Future<void> _init() async {
    if (_initialized) return;

    // Load model from assets
    final modelPath = await ModelLoader().loadFromAssets(
      'assets/vosk_models/en/vosk-model-small-en-us-0.15/',
    );

    _model = await voskFlutterPlugin.createModel(modelPath);
    // Define wake words (can be expanded later)
    final grammar = ['hey griot', 'ok griot'];

    // Create recognizer with grammar
    final recognizer = await voskFlutterPlugin.createRecognizer(
      model: _model,
      sampleRate: 16000,
      grammar: grammar,
    );

    // Init microphone input
    _speechService = await voskFlutterPlugin.initSpeechService(recognizer);

    // Listen for recognized results
    _speechService!.onResult().listen((finalResult) {
      final recognizedText = finalResult.trim().toLowerCase();
      if (grammar.contains(recognizedText)) {
        _controller.add(
          WakeWordEvent(
            detectedWord: recognizedText,
            timestamp: DateTime.now(),
          ),
        );
      }
    });

    // Optional: Listen for partial results
    _speechService!.onPartial().listen((partialResult) {
      // You can emit partials for logging if needed
      // print('[partial] $partialResult');
    });

    _initialized = true;
  }
}
