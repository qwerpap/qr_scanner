import '../repositories/ads_repository.dart';

/// Use case для проверки возможности показа рекламы.
///
/// Проверяет, что пользователь не имеет активной подписки
/// и реклама готова к показу.
class CanShowAdsUseCase {
  final AdsRepository _repository;

  CanShowAdsUseCase(this._repository);

  /// Проверяет, можно ли показывать рекламу.
  ///
  /// Возвращает `true`, если:
  /// - Пользователь не имеет активной подписки
  /// - Реклама готова к показу
  Future<bool> call() => _repository.canShowAds();
}
