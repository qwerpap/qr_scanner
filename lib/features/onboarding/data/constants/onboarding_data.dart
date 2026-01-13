import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/features/onboarding/data/models/onboarding_model.dart';

class OnboardingData {
  OnboardingData._();

  static const List<OnboardingModel> screens = [
    OnboardingModel(
      title: 'Welcome',
      imagePath: ImageSource.onboarding1,
      boldText: 'Scan, Create & Manage QR Codes Easily',
      regularText: '',
      buttonText: 'Next',
      showSkip: true,
    ),
    OnboardingModel(
      title: 'Scan QR Codes',
      imagePath: ImageSource.onboarding2,
      boldText: 'Quickly Scan Any QR Code',
      regularText: 'Align QR codes in frame and get instant\nresults',
      buttonText: 'Next',
      showSkip: true,
    ),
    OnboardingModel(
      title: 'Create QR Codes',
      imagePath: ImageSource.onboarding3,
      boldText: 'Generate QR Codes Instantly',
      regularText: 'Enter URL, text, or contact info and get\nyour custom QR',
      buttonText: 'Next',
      showSkip: true,
    ),
    OnboardingModel(
      title: 'Manage & Share',
      imagePath: ImageSource.onboarding4,
      boldText: 'Save, Share, and Track All Your QR Codes',
      regularText: 'Access My QR Codes and History anytime',
      buttonText: 'Get Started',
      showSkip: false,
    ),
  ];
}
