import 'dart:async';

import 'package:griot_proj/input/voice_input/domain/entities/transcribed_input.dart';
import 'package:griot_proj/input/voice_input/service/voice_input_service.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

class VoiceInputServiceImpl implements VoiceInputService {
  VoiceInputServiceImpl(this.voskFlutterPlugin);

  final VoskFlutterPlugin voskFlutterPlugin;

  final _controller = StreamController<TranscribedInput>.broadcast();

  late Model _model;
  SpeechService? _speechService;
  bool _initialized = false;

  @override
  Stream<TranscribedInput> get transcribedInputStream => _controller.stream;

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

    final modelPath = await ModelLoader().loadFromAssets(
      'assets/vosk_models/en/vosk-model-small-en-us-0.15/',
    );

    _model = await voskFlutterPlugin.createModel(modelPath);

    final recognizer = await voskFlutterPlugin.createRecognizer(
      model: _model,
      sampleRate: 16000,
    );

    _speechService = await voskFlutterPlugin.initSpeechService(recognizer);

    _speechService!.onResult().listen((finalResult) {
      final transcript = finalResult.trim();
      if (transcript.isNotEmpty) {
        _controller.add(
          TranscribedInput(
            text: transcript,
            timestamp: DateTime.now(),
            isFinal: true,
          ),
        );
      }
    });

    _speechService!.onPartial().listen((partialResult) {
      final transcript = partialResult.trim();
      if (transcript.isNotEmpty) {
        _controller.add(
          TranscribedInput(
            text: transcript,
            timestamp: DateTime.now(),
            isFinal: false,
          ),
        );
      }
    });

    _initialized = true;
  }
}
