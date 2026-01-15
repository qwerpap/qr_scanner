import '../repositories/ads_repository.dart';

/// Use case для показа вознаграждаемой рекламы.
class ShowRewardedAdUseCase {
  final AdsRepository _repository;

  ShowRewardedAdUseCase(this._repository);

  /// Показывает вознаграждаемую рекламу.
  ///
  /// [onRewardEarned] - callback, вызываемый при получении награды.
  /// Бросает исключение в случае ошибки.
  Future<void> call({
    required Function(int amount, String type) onRewardEarned,
  }) =>
      _repository.showRewardedAd(onRewardEarned: onRewardEarned);
}
