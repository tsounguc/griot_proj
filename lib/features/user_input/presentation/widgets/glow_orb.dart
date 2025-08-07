import 'package:flutter/material.dart';

class GlowOrb extends StatefulWidget {
  const GlowOrb({
    super.key,
    this.minSize = 100,
    this.maxSize = 130,
    this.duration = const Duration(seconds: 1),
    this.color = const Color(0xFF9C27B0), // Deep purple
  });

  final double minSize;
  final double maxSize;
  final Duration duration;
  final Color color;

  @override
  State<GlowOrb> createState() => _GlowOrbState();
}

class _GlowOrbState extends State<GlowOrb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _glowAnimation =
        Tween<double>(
          begin: widget.minSize,
          end: widget.maxSize,
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (_, __) {
        return Container(
          width: _glowAnimation.value,
          height: _glowAnimation.value,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.6),
                blurRadius: 25,
                spreadRadius: 15,
              ),
            ],
            gradient: RadialGradient(
              colors: [
                widget.color,
                widget.color.withOpacity(0.2),
              ],
              center: Alignment.center,
              radius: 0.8,
            ),
          ),
        );
      },
    );
  }
}
