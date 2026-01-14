import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;

  OnboardingRepositoryImpl({required OnboardingLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<bool> isOnboardingCompleted() async {
    return await _localDataSource.isOnboardingCompleted();
  }

  @override
  Future<void> setOnboardingCompleted(bool value) async {
    await _localDataSource.setOnboardingCompleted(value);
  }
}
