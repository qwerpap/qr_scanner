import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class QrCodeSection extends StatefulWidget {
  const QrCodeSection({super.key});

  @override
  State<QrCodeSection> createState() => _QrCodeSectionState();
}

class _QrCodeSectionState extends State<QrCodeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 280,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Center(
            child: Text(
              'QR Code Placeholder',
              style: TextStyle(color: AppColors.greyTextColor),
            ),
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final position = _animation.value * 278;
              return Positioned(
                top: position,
                left: 0,
                right: 0,
                child: Container(
                  height: 2.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromRGBO(0, 0, 0, 0),
                        AppColors.primaryColor,
                        const Color.fromRGBO(0, 0, 0, 0),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
