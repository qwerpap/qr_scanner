import 'package:flutter/material.dart';
import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/onboarding/data/models/onboarding_model.dart';

class OnboardingData {
  OnboardingData._();

  static List<OnboardingModel> getScreens(BuildContext context) {
    return [
      OnboardingModel(
        title: context.l10n.onboardingWelcomeTitle,
        imagePath: ImageSource.onboarding1,
        boldText: context.l10n.onboardingWelcomeBold,
        regularText: '',
        buttonText: context.l10n.next,
        showSkip: true,
      ),
      OnboardingModel(
        title: context.l10n.onboardingScanTitle,
        imagePath: ImageSource.onboarding2,
        boldText: context.l10n.onboardingScanBold,
        regularText: context.l10n.onboardingScanRegular,
        buttonText: context.l10n.next,
        showSkip: true,
      ),
      OnboardingModel(
        title: context.l10n.onboardingCreateTitle,
        imagePath: ImageSource.onboarding3,
        boldText: context.l10n.onboardingCreateBold,
        regularText: context.l10n.onboardingCreateRegular,
        buttonText: context.l10n.next,
        showSkip: true,
      ),
      OnboardingModel(
        title: context.l10n.onboardingManageTitle,
        imagePath: ImageSource.onboarding4,
        boldText: context.l10n.onboardingManageBold,
        regularText: context.l10n.onboardingManageRegular,
        buttonText: context.l10n.getStarted,
        showSkip: false,
      ),
    ];
  }
}
