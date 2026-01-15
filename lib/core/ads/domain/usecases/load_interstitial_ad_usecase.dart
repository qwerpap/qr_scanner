import '../repositories/ads_repository.dart';

/// Use case для загрузки межстраничной рекламы.
class LoadInterstitialAdUseCase {
  final AdsRepository _repository;

  LoadInterstitialAdUseCase(this._repository);

  /// Загружает межстраничную рекламу.
  ///
  /// Возвращает `true`, если реклама успешно загружена.
  Future<bool> call() => _repository.loadInterstitialAd();
}
