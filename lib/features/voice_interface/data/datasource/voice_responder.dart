import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:griot_proj/core/utils/type_defs.dart';

abstract class VoiceResponder {
  Future<void> speak({
    required String message,
    required String currentLanguage,
  });
}

class VoiceResponderImpl implements VoiceResponder {
  const VoiceResponderImpl(this._tts);
  final FlutterTts _tts;

  @override
  Future<void> speak({required String message, required String currentLanguage}) async {
    final completer = Completer<void>();

    // final voices = await _tts.getVoices;
    // var voice = <String, dynamic>{};
    // for (final v in voices as List) {
    //   print(v);
    //   // voice = v as DataMap;
    // }

    // await _tts.setVoice({
    //   'name': voice['name'] as String,
    //   'locale': voice['locale'] as String,
    // });

    _tts.setCompletionHandler(() {
      if (!completer.isCompleted) {
        completer.complete();
      }
    });

    await _tts.speak(message);

    return completer.future;
  }
}
