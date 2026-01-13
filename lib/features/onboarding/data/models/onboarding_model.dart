import 'package:equatable/equatable.dart';

class OnboardingModel extends Equatable {
  const OnboardingModel({
    required this.title,
    required this.imagePath,
    required this.boldText,
    required this.regularText,
    required this.buttonText,
    required this.showSkip,
  });

  final String title;
  final String imagePath;
  final String boldText;
  final String regularText;
  final String buttonText;
  final bool showSkip;

  @override
  List<Object?> get props => [
        title,
        imagePath,
        boldText,
        regularText,
        buttonText,
        showSkip,
      ];
}
