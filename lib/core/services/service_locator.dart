import 'package:get_it/get_it.dart';
import 'package:griot_proj/input/wake_word/data/data_sources/wake_word_service_impl.dart';
import 'package:griot_proj/input/wake_word/data/repository/wake_word_repository_impl.dart';
import 'package:griot_proj/input/wake_word/domain/repositories/wake_word_repository.dart';
import 'package:griot_proj/input/wake_word/domain/use_cases/listen_for_wake_word.dart';
import 'package:griot_proj/input/wake_word/domain/use_cases/start_wake_word_listening.dart';
import 'package:griot_proj/input/wake_word/domain/use_cases/stop_wake_listening_listening.dart';
import 'package:griot_proj/input/wake_word/presentation/cubit/wake_word_cubit.dart';
import 'package:griot_proj/input/wake_word/service/wake_word_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vosk_flutter_2/vosk_flutter_2.dart';

part 'service_locator.main.dart';
