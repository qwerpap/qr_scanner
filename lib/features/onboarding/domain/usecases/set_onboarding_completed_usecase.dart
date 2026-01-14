import '../repositories/onboarding_repository.dart';

class SetOnboardingCompletedUseCase {
  final OnboardingRepository _repository;

  SetOnboardingCompletedUseCase({required OnboardingRepository repository})
    : _repository = repository;

  Future<void> call(bool value) async {
    await _repository.setOnboardingCompleted(value);
  }
}
