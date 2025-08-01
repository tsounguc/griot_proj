part of 'service_locator.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initUserInput();
}

Future<void> _initUserInput() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator
    // App Logic
    ..registerFactory(
      () => WakeWordCubit(
        listenForWakeWord: serviceLocator(),
        speakResponse: serviceLocator(),
        listenToSpeech: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => ListenForWakeWord(serviceLocator()))
    ..registerLazySingleton(() => SpeakResponse(serviceLocator()))
    ..registerLazySingleton(() => ListenToSpeech(serviceLocator()))
    // Repositories
    ..registerLazySingleton<UserInputRepository>(
      () => UserInputRepositoryImpl(
        wakeWordListener: serviceLocator(),
        speechRecognizer: serviceLocator(),
      ),
    )
    ..registerLazySingleton<VoiceResponderRepository>(
      () => VoiceResponderRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<WakeWordListener>(
      WakeWordListenerImpl.new,
    )
    ..registerLazySingleton<VoiceResponder>(
      () => VoiceResponderImpl(serviceLocator()),
    )
    ..registerLazySingleton<SpeechRecognizer>(
      () => SpeechRecognizerImpl(serviceLocator()),
    )
    // External dependencies
    ..registerLazySingleton(
      () => FlutterTts()
        ..setLanguage('en-US')
        ..setPitch(1)
        ..setSpeechRate(0.45),
    )
    ..registerLazySingleton(SpeechToText.new)
    ..registerLazySingleton(() => prefs);
}
