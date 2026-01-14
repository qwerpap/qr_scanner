import '../../../../core/subscription/subscription_product.dart';
import '../repositories/paywall_repository.dart';

/// Use case для покупки подписки.
class PurchaseSubscriptionUseCase {
  final PaywallRepository _repository;

  PurchaseSubscriptionUseCase(this._repository);

  Future<void> call(SubscriptionProduct product) {
    return _repository.purchaseProduct(product);
  }
}
