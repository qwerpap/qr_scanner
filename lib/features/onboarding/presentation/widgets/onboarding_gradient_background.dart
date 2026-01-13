import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class OnboardingGradientBackground extends StatelessWidget {
  const OnboardingGradientBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.onboardingGradientEnd,
            AppColors.whiteColor,
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      child: child,
    );
  }
}
