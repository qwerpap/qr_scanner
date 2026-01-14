import '../repositories/paywall_repository.dart';

/// Use case для восстановления покупок.
class RestoreSubscriptionsUseCase {
  final PaywallRepository _repository;

  RestoreSubscriptionsUseCase(this._repository);

  Future<void> call() {
    return _repository.restorePurchases();
  }
}
