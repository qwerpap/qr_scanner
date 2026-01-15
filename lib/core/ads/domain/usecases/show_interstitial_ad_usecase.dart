import '../repositories/ads_repository.dart';

/// Use case для показа межстраничной рекламы.
class ShowInterstitialAdUseCase {
  final AdsRepository _repository;

  ShowInterstitialAdUseCase(this._repository);

  /// Показывает межстраничную рекламу.
  ///
  /// Бросает исключение в случае ошибки.
  Future<void> call() => _repository.showInterstitialAd();
}
