import '../repositories/ads_repository.dart';

/// Use case для инициализации AdMob SDK.
class InitAdsUseCase {
  final AdsRepository _repository;

  InitAdsUseCase(this._repository);

  /// Инициализирует AdMob SDK.
  Future<void> call() => _repository.init();
}
