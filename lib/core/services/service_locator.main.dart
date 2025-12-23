part of 'service_locator.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
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
