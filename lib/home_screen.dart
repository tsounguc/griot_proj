import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/features/user_input/presentation/cubit/user_input_cubit.dart';
import 'package:griot_proj/features/user_input/presentation/widgets/wave_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wake Word Listener')),
      body: Center(
        child: BlocConsumer<WakeWordCubit, UserInputState>(
          listener: (context, state) {
            if (state is WaitingForUserInput) {
              context.read<WakeWordCubit>().listenToUserSpeech();
            }
            if (state is UserVoiceInputCaptured) {
              context.read<WakeWordCubit>().analyzeVoiceInput(state.text);
            }
            if (state is UserVoiceInputAnalyzed) {
              context.read<WakeWordCubit>().getResponse(state.result);
            }
            if (state is GRIOTResponseReceived) {
              context.read<WakeWordCubit>().respondVocally(state.text);
            }
          },
          builder: (context, state) {
            print(state);
            if (state is WakeWordListening) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WaveAnimation(),
                  Text('🎙️ Listening...'),
                ],
              );
            } else if (state is WakeWordHeard) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WaveAnimation(),
                  Text('🗣️ Wake word detected!'),
                ],
              );
            } else if (state is UserInputError) {
              return Text('❌ Error: ${state.message}');
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
