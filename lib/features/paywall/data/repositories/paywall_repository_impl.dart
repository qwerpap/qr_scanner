import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/subscription/apphud_service.dart';
import '../../../../core/subscription/subscription_product.dart';
import '../../../../core/subscription/subscription_status.dart';
import '../../domain/repositories/paywall_repository.dart';

/// Реализация PaywallRepository через AppHudService.
class PaywallRepositoryImpl implements PaywallRepository {
  final AppHudService _appHudService;
  final Talker _talker;

  PaywallRepositoryImpl({
    required AppHudService appHudService,
    required Talker talker,
  })  : _appHudService = appHudService,
        _talker = talker;

  @override
  Future<List<SubscriptionProduct>> getPaywallProducts() async {
    try {
      return await _appHudService.getPaywallProducts();
    } catch (e, stackTrace) {
      _talker.error('PaywallRepository: Failed to get products', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> purchaseProduct(SubscriptionProduct product) async {
    try {
      await _appHudService.purchase(product);
    } catch (e, stackTrace) {
      _talker.error('PaywallRepository: Failed to purchase', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> restorePurchases() async {
    try {
      await _appHudService.restore();
    } catch (e, stackTrace) {
      _talker.error('PaywallRepository: Failed to restore', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    try {
      return await _appHudService.getSubscriptionStatus();
    } catch (e, stackTrace) {
      _talker.error('PaywallRepository: Failed to get status', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> isPremium() async {
    try {
      return await _appHudService.isPremium();
    } catch (e, stackTrace) {
      _talker.error('PaywallRepository: Failed to check premium', e, stackTrace);
      return false;
    }
  }
}
