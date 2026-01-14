import '../../../../core/subscription/subscription_product.dart';
import '../../../../core/subscription/subscription_status.dart';

/// Абстракция репозитория для работы с подписками.
abstract class PaywallRepository {
  /// Получает список продуктов для paywall.
  Future<List<SubscriptionProduct>> getPaywallProducts();

  /// Выполняет покупку продукта.
  Future<void> purchaseProduct(SubscriptionProduct product);

  /// Восстанавливает покупки.
  Future<void> restorePurchases();

  /// Проверяет статус подписки.
  Future<SubscriptionStatus> getSubscriptionStatus();

  /// Проверяет, является ли пользователь premium.
  Future<bool> isPremium();
}
