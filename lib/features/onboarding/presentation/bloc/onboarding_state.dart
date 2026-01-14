import 'package:equatable/equatable.dart';

/// Base class for onboarding states
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

/// State when checking onboarding status
class OnboardingChecking extends OnboardingState {
  const OnboardingChecking();
}

/// State when onboarding is completed
class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}

/// State when onboarding is not completed
class OnboardingNotCompleted extends OnboardingState {
  const OnboardingNotCompleted();
}

/// State when an error occurred
class OnboardingError extends OnboardingState {
  final String message;

  const OnboardingError(this.message);

  @override
  List<Object?> get props => [message];
}
