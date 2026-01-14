import '../../../../core/subscription/subscription_status.dart';
import '../repositories/paywall_repository.dart';

/// Use case для проверки статуса подписки.
class CheckSubscriptionStatusUseCase {
  final PaywallRepository _repository;

  CheckSubscriptionStatusUseCase(this._repository);

  Future<SubscriptionStatus> call() {
    return _repository.getSubscriptionStatus();
  }
}
