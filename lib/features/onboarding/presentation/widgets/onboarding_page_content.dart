import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/onboarding/data/models/onboarding_model.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    super.key,
    required this.screen,
  });

  final OnboardingModel screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Text(
            screen.title,
            style: AppFonts.titleLarge.copyWith(
              fontSize: 36,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            flex: 3,
            child: Image.asset(
              screen.imagePath,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24),
          if (screen.boldText.isNotEmpty)
            Text(
              screen.boldText,
              textAlign: TextAlign.center,
              style: AppFonts.titleLarge.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          if (screen.regularText.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              screen.regularText,
              textAlign: TextAlign.center,
              style: AppFonts.titleMedium.copyWith(
                color: AppColors.greyTextColor,
              ),
            ),
          ] else if (screen.boldText.isNotEmpty) ...[
            const SizedBox(height: 14),
          ],
          const SizedBox(height: 39),
        ],
      ),
    );
  }
}
