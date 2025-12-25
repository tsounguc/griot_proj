part of 'service_locator.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initVoiceInput();
  await _initWakeWord();
}

Future<void> _initWakeWord() async {
  final prefs = await SharedPreferences.getInstance();
  serviceLocator
    // App Logic
    ..registerFactory(
      () => WakeWordCubit(
        listenForWakeWord: serviceLocator(),
        startWakeWordListening: serviceLocator(),
        stopWakeListening: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => ListenForWakeWord(serviceLocator()))
    ..registerLazySingleton(() => StartWakeWordListening(serviceLocator()))
    ..registerLazySingleton(() => StopWakeListening(serviceLocator()))
    // Repositories
    ..registerLazySingleton<WakeWordRepository>(
      () => WakeWordRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<WakeWordService>(
      () => WakeWordServiceImpl(serviceLocator()),
    )
    // External dependencies
    ..registerLazySingleton(VoskFlutterPlugin.instance);
}

Future<void> _initVoiceInput() async {
  serviceLocator
    // App Logic
    ..registerFactory(
      () => VoiceInputCubit(
        listenToVoiceInput: serviceLocator(),
        startVoiceInput: serviceLocator(),
        stopVoiceInput: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => ListenToVoiceInput(serviceLocator()))
    ..registerLazySingleton(() => StartVoiceInput(serviceLocator()))
    ..registerLazySingleton(() => StopVoiceInput(serviceLocator()))
    // Repositories
    ..registerLazySingleton<VoiceInputRepository>(
      () => VoiceInputRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<VoiceInputService>(
      () => VoiceInputServiceImpl(serviceLocator()),
    );
}
