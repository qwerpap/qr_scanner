import '../repositories/ads_repository.dart';

/// Use case для загрузки баннерной рекламы.
class LoadBannerAdUseCase {
  final AdsRepository _repository;

  LoadBannerAdUseCase(this._repository);

  /// Загружает баннерную рекламу.
  ///
  /// Возвращает `true`, если реклама успешно загружена.
  Future<bool> call() => _repository.loadBannerAd();
}
