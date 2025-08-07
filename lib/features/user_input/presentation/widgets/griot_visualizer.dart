import 'package:flutter/material.dart';
import 'package:griot_proj/features/user_input/presentation/widgets/glow_orb.dart';

class GriotVisualizer extends StatelessWidget {
  const GriotVisualizer({
    super.key,
    required this.label,
    this.animation,
  });
  final String label;
  final Widget? animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // const GlowOrb(), // Always show GRIOT orb
        // const SizedBox(height: 30),
        if (animation != null) animation!,
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Orbitron', // Optional: use a futuristic font
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
