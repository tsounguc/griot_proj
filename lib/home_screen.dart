import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/features/user_input/presentation/cubit/user_input_cubit.dart';
import 'package:griot_proj/features/user_input/presentation/widgets/glow_orb.dart';
import 'package:griot_proj/features/user_input/presentation/widgets/griot_visualizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRIOT'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFF4A00E0),
              Colors.black,
            ],
            radius: 1.2,
          ),
        ),
        child: Center(
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
              if (state is WakeWordListening) {
                return const GriotVisualizer(
                  label: '🎙️ Listening for "Hey GRIOT"...',
                  animation: GlowOrb(),
                );
              } else if (state is WakeWordHeard) {
                return const GriotVisualizer(
                  label: '🗣️ Wake word detected!',
                  animation: GlowOrb(),
                );
              } else if (state is WaitingForUserInput) {
                return const GriotVisualizer(
                  label: '👂 Waiting for your question...',
                  animation: GlowOrb(),
                );
              } else if (state is UserVoiceInputAnalyzed) {
                return const GriotVisualizer(
                  label: '🧠 Thinking...',
                  animation: GlowOrb(),
                );
              } else if (state is GRIOTResponseReceived) {
                return GriotVisualizer(
                  label: state.text,
                  animation: const GlowOrb(
                    minSize: 120,
                    maxSize: 150,
                    duration: Duration(milliseconds: 600),
                    color: Colors.deepPurpleAccent,
                  ),
                );
              } else if (state is UserInputError) {
                return GriotVisualizer(
                  label: '❌ Error: ${state.message}',
                );
              }
              return const GriotVisualizer(
                label: 'Tap the mic or say "Hey GRIOT"',
              );
            },
          ),
        ),
      ),
    );
  }
}
