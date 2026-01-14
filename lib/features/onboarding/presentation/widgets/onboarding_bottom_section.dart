import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/onboarding/data/models/onboarding_model.dart';
import 'package:qr_scanner/features/onboarding/presentation/widgets/onboarding_pagination.dart';

class OnboardingBottomSection extends StatelessWidget {
  const OnboardingBottomSection({
    super.key,
    required this.currentScreen,
    required this.currentIndex,
    required this.totalScreens,
    required this.onNextPressed,
    required this.onSkipPressed,
  });

  final OnboardingModel currentScreen;
  final int currentIndex;
  final int totalScreens;
  final VoidCallback onNextPressed;
  final VoidCallback onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          OnboardingPagination(
            currentIndex: currentIndex,
            itemCount: totalScreens,
          ),
          const SizedBox(height: 21),
          CustomElevatedButton(
            onPressed: onNextPressed,
            title: currentScreen.buttonText,
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 20,
            child: currentScreen.showSkip
                ? GestureDetector(
                    onTap: onSkipPressed,
                    child: Text(
                      context.l10n.skip,
                      style: AppFonts.titleMedium.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
