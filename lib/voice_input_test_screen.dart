import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:griot_proj/input/voice_input/presentation/cubit/voice_input_cubit.dart';
import 'package:griot_proj/input/voice_input/presentation/cubit/voice_input_state.dart';

class VoiceInputTestScreen extends StatelessWidget {
  const VoiceInputTestScreen({super.key});

  // static const id = '/voice-input-test';

  static const id = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Input Test')),
      body: BlocBuilder<VoiceInputCubit, VoiceInputState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  switch (state) {
                    VoiceInputInitial() => 'Idle',
                    VoiceInputListening() => 'Listening...',
                    VoiceInputTranscribed() =>
                      'You said: ${state.transcribedInput.text}',
                    VoiceInputError(:final message) => 'Error: $message',
                    VoiceInputStopped() => 'Stopped',
                  },
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<VoiceInputCubit>().startListening(),
                      icon: const Icon(Icons.mic),
                      label: const Text('Start'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.read<VoiceInputCubit>().stopListening(),
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
