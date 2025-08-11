part of 'service_locator.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUpServices() async {
  await _initRemember();
  await _initReflect();
  await _initVoiceResponder();
  await _initInputRouter();
  await _initModelContext();
  await _initUnderstand();
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
        analyzeInput: serviceLocator(),
        inputRouter: serviceLocator(),
        saveContextMemory: serviceLocator(),
        logConversationEntry: serviceLocator(),
        detectLanguage: serviceLocator(),
        setCurrentLanguage: serviceLocator(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => ListenForWakeWord(serviceLocator()))
    ..registerLazySingleton(() => ListenToSpeech(serviceLocator()))
    // Repositories
    ..registerLazySingleton<VoiceInputRepository>(
      () => VoiceInputRepositoryImpl(remoteDataSource: serviceLocator()),
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
        ..setLanguage('en-ZA')
        ..setPitch(1)
        ..setVoice({'name': 'en-ZA-Wavenet-A', 'locale': 'en-ZA'})
        ..setSpeechRate(0.45),
    )
    ..registerLazySingleton(SpeechToText.new)
    ..registerLazySingleton(() => prefs);
}

Future<void> _initUnderstand() async {
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
      UnderstandRemoteDataSourceImpl.new,
    )
  // External dependencies
  ;
}

Future<void> _initModelContext() async {
  serviceLocator
    // App Logic
    // Use cases
    ..registerLazySingleton(() => SelectRole(serviceLocator()))
    ..registerLazySingleton(BuildPrompt.new)
    ..registerLazySingleton(() => SaveContextMemory(serviceLocator()))
    ..registerLazySingleton(() => GetRecentContextMemory(serviceLocator()))
    // Repositories
    ..registerLazySingleton<RoleSelectorRepository>(
      () => RoleSelectorRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton<ContextMemoryRepository>(
      () => ContextMemoryRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<RoleSelector>(
      RoleSelectorImpl.new,
    )
    ..registerLazySingleton<ContextMemoryLocalDataSource>(
      () => ContextMemoryLocalDataSourceImpl(serviceLocator()),
    )
  // External dependencies
  ;
}

Future<void> _initInputRouter() async {
  serviceLocator
    // App Logic
    // Use cases
    ..registerLazySingleton(
      () => InputRouter(
        selectRole: serviceLocator(),
        buildPrompt: serviceLocator(),
        getGPTResponse: serviceLocator(),
        getRecentContextMemory: serviceLocator(),
        getCurrentLanguage: serviceLocator(),
      ),
    )
  // Repositories
  // Data Source
  // External dependencies
  ;
}

Future<void> _initVoiceResponder() async {
  serviceLocator
    // App Logic
    // Use cases
    ..registerLazySingleton(() => SpeakResponse(serviceLocator()))
    // Repositories
    ..registerLazySingleton<VoiceResponderRepository>(
      () => VoiceResponderRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<VoiceResponder>(() => VoiceResponderImpl(serviceLocator()))
  // External dependencies
  ;
}

Future<void> _initReflect() async {
  serviceLocator
    // App Logic
    // Use cases
    ..registerLazySingleton(() => GetGPTResponse(serviceLocator()))
    // Repositories
    ..registerLazySingleton<ReflectRepository>(
      () => ReflectRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<ReflectRemoteDataSource>(ReflectRemoteDataSourceImpl.new)
  // External dependencies
  ;
}

Future<void> _initRemember() async {
  serviceLocator
    // App Logic
    // Use cases
    ..registerLazySingleton(() => GetConversationHistory(serviceLocator()))
    ..registerLazySingleton(() => LogConversationEntry(serviceLocator()))
    // Repositories
    ..registerLazySingleton<ConversationHistoryRepository>(
      () => ConversationHistoryRepositoryImpl(serviceLocator()),
    )
    // Data Source
    ..registerLazySingleton<ConversationHistoryLocalDataSource>(ConversationHistoryLocalDataSourceImpl.new)
  // External dependencies
  ;
}
