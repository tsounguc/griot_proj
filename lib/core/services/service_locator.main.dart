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
    ..registerLazySingleton<VoiceInputRepository>(
      () => VoiceInputRepositoryImpl(remoteDataSource: serviceLocator()),
    )
    ..registerLazySingleton<VoiceResponderRepository>(
      () => VoiceResponderRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<VoiceInputRemoteDataSource>(
      () => VoiceInputRemoteDataSourceImpl(
        speechToText: serviceLocator(),
      ),
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

Future<void> _initUnderstand() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator
    // App Logic
    // Use cases
    ..registerLazySingleton(() => AnalyzeInput(serviceLocator()))
    // Repositories
    ..registerLazySingleton<UnderstandRepository>(
      () => UnderstandRepositoryImpl(remoteDataSource: serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<UnderstandRemoteDataSource>(
      () => UnderstandRemoteDataSourceImpl(),
    )
  // External dependencies
  ;
}
