import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:griot_proj/features/user_input/data/datasources/speech_recognizer.dart';
import 'package:griot_proj/features/user_input/data/datasources/wake_word_listener.dart';
import 'package:griot_proj/features/user_input/data/repositories/user_input_repository_impl.dart';
import 'package:griot_proj/features/user_input/domain/repositories/user_input_repository.dart';
import 'package:griot_proj/features/user_input/domain/use_cases/listen_for_wake_word.dart';
import 'package:griot_proj/features/user_input/domain/use_cases/listen_to_speech.dart';
import 'package:griot_proj/features/user_input/presentation/cubit/user_input_cubit.dart';
import 'package:griot_proj/features/voice_interface/data/datasource/voice_responder.dart';
import 'package:griot_proj/features/voice_interface/data/respositories/voice_responder_repository_impl.dart';
import 'package:griot_proj/features/voice_interface/domain/repostories/voice_responder_repository.dart';
import 'package:griot_proj/features/voice_interface/domain/use_cases/speak_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

part 'service_locator.main.dart';
