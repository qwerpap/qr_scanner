import '../repositories/onboarding_repository.dart';

class CheckOnboardingCompletedUseCase {
  final OnboardingRepository _repository;

  CheckOnboardingCompletedUseCase({required OnboardingRepository repository})
    : _repository = repository;

  Future<bool> call() async {
    return await _repository.isOnboardingCompleted();
  }
}
