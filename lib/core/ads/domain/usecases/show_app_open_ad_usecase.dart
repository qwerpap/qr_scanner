import '../repositories/ads_repository.dart';

/// Use case для показа App Open рекламы.
class ShowAppOpenAdUseCase {
  final AdsRepository _repository;

  ShowAppOpenAdUseCase(this._repository);

  /// Показывает App Open рекламу.
  ///
  /// Бросает исключение в случае ошибки.
  Future<void> call() => _repository.showAppOpenAd();
}
