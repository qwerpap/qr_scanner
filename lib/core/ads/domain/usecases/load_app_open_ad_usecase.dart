import '../repositories/ads_repository.dart';

/// Use case для загрузки App Open рекламы.
class LoadAppOpenAdUseCase {
  final AdsRepository _repository;

  LoadAppOpenAdUseCase(this._repository);

  /// Загружает App Open рекламу.
  ///
  /// Возвращает `true`, если реклама успешно загружена.
  Future<bool> call() => _repository.loadAppOpenAd();
}
