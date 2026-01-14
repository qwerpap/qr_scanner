import '../../../../core/subscription/subscription_product.dart';
import '../repositories/paywall_repository.dart';

/// Use case для получения продуктов paywall.
class GetPaywallProductsUseCase {
  final PaywallRepository _repository;

  GetPaywallProductsUseCase(this._repository);

  Future<List<SubscriptionProduct>> call() {
    return _repository.getPaywallProducts();
  }
}
