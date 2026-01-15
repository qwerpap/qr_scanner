import '../repositories/ads_repository.dart';

/// Use case для загрузки вознаграждаемой рекламы.
class LoadRewardedAdUseCase {
  final AdsRepository _repository;

  LoadRewardedAdUseCase(this._repository);

  /// Загружает вознаграждаемую рекламу.
  ///
  /// Возвращает `true`, если реклама успешно загружена.
  Future<bool> call() => _repository.loadRewardedAd();
}
