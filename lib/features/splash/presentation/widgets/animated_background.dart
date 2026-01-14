import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Large dominant circle - top right (partially out of screen)
            _AnimatedCircle(
              controller: _controller,
              size: 280,
              top: -120,
              right: -100,
              color: const Color.fromRGBO(122, 203, 255, 0.08),
              delay: 0.0,
              duration: 10,
              offsetRange: 15,
              scaleRange: 0.03,
            ),
            // Large dominant circle - bottom left (partially out of screen)
            _AnimatedCircle(
              controller: _controller,
              size: 260,
              bottom: -100,
              left: -80,
              color: const Color.fromRGBO(232, 247, 255, 0.1),
              delay: 0.3,
              duration: 12,
              offsetRange: 18,
              scaleRange: 0.04,
            ),
            // Large circles (120-220px)
            _AnimatedCircle(
              controller: _controller,
              size: 200,
              top: 100,
              right: 40,
              color: const Color.fromRGBO(255, 245, 235, 0.12),
              delay: 0.1,
              duration: 9,
              offsetRange: 12,
              scaleRange: 0.05,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 180,
              bottom: 150,
              right: 60,
              color: const Color.fromRGBO(200, 255, 200, 0.1),
              delay: 0.5,
              duration: 11,
              offsetRange: 14,
              scaleRange: 0.04,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 160,
              top: 250,
              left: 30,
              color: const Color.fromRGBO(232, 247, 255, 0.15),
              delay: 0.7,
              duration: 7,
              offsetRange: 10,
              scaleRange: 0.06,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 150,
              bottom: 80,
              left: 50,
              color: const Color.fromRGBO(255, 245, 235, 0.1),
              delay: 0.4,
              duration: 8,
              offsetRange: 11,
              scaleRange: 0.05,
            ),
            // Medium circles (40-80px)
            _AnimatedCircle(
              controller: _controller,
              size: 80,
              top: 180,
              right: 100,
              color: const Color.fromRGBO(122, 203, 255, 0.15),
              delay: 0.2,
              duration: 6,
              offsetRange: 8,
              scaleRange: 0.08,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 70,
              top: 350,
              left: 100,
              color: const Color.fromRGBO(119, 201, 126, 0.12),
              delay: 0.6,
              duration: 9,
              offsetRange: 9,
              scaleRange: 0.07,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 65,
              bottom: 250,
              right: 120,
              color: const Color.fromRGBO(255, 184, 108, 0.14),
              delay: 0.3,
              duration: 7,
              offsetRange: 7,
              scaleRange: 0.09,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 60,
              top: 120,
              left: 150,
              color: const Color.fromRGBO(232, 247, 255, 0.18),
              delay: 0.8,
              duration: 10,
              offsetRange: 10,
              scaleRange: 0.06,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 55,
              bottom: 180,
              left: 200,
              color: const Color.fromRGBO(255, 245, 235, 0.16),
              delay: 0.5,
              duration: 8,
              offsetRange: 6,
              scaleRange: 0.1,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 50,
              top: 280,
              right: 80,
              color: const Color.fromRGBO(200, 255, 200, 0.14),
              delay: 0.4,
              duration: 11,
              offsetRange: 9,
              scaleRange: 0.07,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 45,
              bottom: 300,
              left: 80,
              color: const Color.fromRGBO(122, 203, 255, 0.13),
              delay: 0.7,
              duration: 6,
              offsetRange: 8,
              scaleRange: 0.08,
            ),
            // Small circles (8-20px)
            _AnimatedCircle(
              controller: _controller,
              size: 20,
              top: 80,
              right: 60,
              color: const Color.fromRGBO(122, 203, 255, 0.2),
              delay: 0.1,
              duration: 5,
              offsetRange: 5,
              scaleRange: 0.12,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 18,
              top: 150,
              left: 40,
              color: const Color.fromRGBO(255, 184, 108, 0.18),
              delay: 0.3,
              duration: 7,
              offsetRange: 6,
              scaleRange: 0.1,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 16,
              top: 220,
              right: 150,
              color: const Color.fromRGBO(119, 201, 126, 0.2),
              delay: 0.5,
              duration: 6,
              offsetRange: 4,
              scaleRange: 0.15,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 14,
              bottom: 200,
              left: 60,
              color: const Color.fromRGBO(232, 247, 255, 0.19),
              delay: 0.2,
              duration: 8,
              offsetRange: 5,
              scaleRange: 0.13,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 12,
              bottom: 150,
              right: 80,
              color: const Color.fromRGBO(255, 245, 235, 0.17),
              delay: 0.6,
              duration: 9,
              offsetRange: 4,
              scaleRange: 0.14,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 10,
              top: 300,
              left: 120,
              color: const Color.fromRGBO(122, 203, 255, 0.2),
              delay: 0.4,
              duration: 7,
              offsetRange: 3,
              scaleRange: 0.16,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 8,
              bottom: 100,
              right: 140,
              color: const Color.fromRGBO(119, 201, 126, 0.18),
              delay: 0.8,
              duration: 5,
              offsetRange: 3,
              scaleRange: 0.18,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 9,
              top: 380,
              right: 200,
              color: const Color.fromRGBO(255, 184, 108, 0.19),
              delay: 0.7,
              duration: 6,
              offsetRange: 4,
              scaleRange: 0.15,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 11,
              bottom: 350,
              left: 150,
              color: const Color.fromRGBO(232, 247, 255, 0.2),
              delay: 0.3,
              duration: 8,
              offsetRange: 5,
              scaleRange: 0.14,
            ),
            _AnimatedCircle(
              controller: _controller,
              size: 13,
              top: 450,
              left: 80,
              color: const Color.fromRGBO(200, 255, 200, 0.17),
              delay: 0.5,
              duration: 7,
              offsetRange: 4,
              scaleRange: 0.16,
            ),
          ],
        );
      },
    );
  }
}

class _AnimatedCircle extends StatelessWidget {
  const _AnimatedCircle({
    required this.controller,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.color,
    required this.delay,
    required this.duration,
    required this.offsetRange,
    required this.scaleRange,
  });

  final AnimationController controller;
  final double size;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final Color color;
  final double delay;
  final int duration;
  final double offsetRange;
  final double scaleRange;

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay,
          (delay + 0.5).clamp(0.0, 1.0),
          curve: Curves.easeInOut,
        ),
      ),
    );

    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          // Smooth floating movement
          final offset = (animation.value - 0.5) * offsetRange;
          // Subtle pulsing scale
          final scale = 1.0 + (animation.value - 0.5) * scaleRange;

          return Transform.translate(
            offset: Offset(
              offset * math.cos(delay * math.pi * 2),
              offset * math.sin(delay * math.pi * 2),
            ),
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              ),
            ),
          );
        },
      ),
    );
  }
}
