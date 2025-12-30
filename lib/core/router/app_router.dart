import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/core/services/service_locator.dart';
import 'package:griot_proj/features/user_input/presentation/cubit/user_input_cubit.dart';
import 'package:griot_proj/input/voice_input/presentation/cubit/voice_input_cubit.dart';
import 'package:griot_proj/voice_input_test_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case VoiceInputTestScreen.id:
        return _pageBuilder(
          (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    serviceLocator<WakeWordCubit>()..listenForWakeWord(),
              ),
              BlocProvider(
                create: (_) => serviceLocator<VoiceInputCubit>(),
              ),
            ],
            child: const VoiceInputTestScreen(),
          ),
          settings: settings,
        );
      default:
        return _pageBuilder(
          (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget Function(BuildContext context) page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder(
    settings: settings,
    transitionsBuilder: (_, animation, __, child) => FadeTransition(
      opacity: animation,
      child: child,
    ),
    pageBuilder: (context, _, __) => page(context),
  );
}
