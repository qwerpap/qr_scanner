import 'package:equatable/equatable.dart';

/// Base class for onboarding events
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

/// Event to check onboarding status
class CheckOnboardingStatus extends OnboardingEvent {
  const CheckOnboardingStatus();
}

/// Event to complete onboarding
class CompleteOnboarding extends OnboardingEvent {
  const CompleteOnboarding();
}
