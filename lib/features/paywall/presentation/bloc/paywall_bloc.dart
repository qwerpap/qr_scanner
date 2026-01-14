import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/services/attribution/appsflyer_service.dart';
import '../../../../core/subscription/subscription_product.dart';
import '../../../../core/subscription/subscription_status.dart';
import '../../domain/usecases/get_paywall_products_usecase.dart';
import '../../domain/usecases/purchase_subscription_usecase.dart';
import '../../domain/usecases/restore_subscriptions_usecase.dart';
import '../../domain/usecases/check_subscription_status_usecase.dart';
import 'paywall_event.dart';
import 'paywall_state.dart';

class PaywallBloc extends Bloc<PaywallEvent, PaywallState> {
  final GetPaywallProductsUseCase _getPaywallProductsUseCase;
  final PurchaseSubscriptionUseCase _purchaseSubscriptionUseCase;
  final RestoreSubscriptionsUseCase _restoreSubscriptionsUseCase;
  final CheckSubscriptionStatusUseCase _checkSubscriptionStatusUseCase;
  final AppsFlyerService _appsFlyerService;
  final Talker _talker;

  // Сохраняем последний список продуктов для восстановления состояния после ошибки
  List<SubscriptionProduct> _lastProducts = [];

  PaywallBloc({
    required GetPaywallProductsUseCase getPaywallProductsUseCase,
    required PurchaseSubscriptionUseCase purchaseSubscriptionUseCase,
    required RestoreSubscriptionsUseCase restoreSubscriptionsUseCase,
    required CheckSubscriptionStatusUseCase checkSubscriptionStatusUseCase,
    required AppsFlyerService appsFlyerService,
    required Talker talker,
  }) : _getPaywallProductsUseCase = getPaywallProductsUseCase,
       _purchaseSubscriptionUseCase = purchaseSubscriptionUseCase,
       _restoreSubscriptionsUseCase = restoreSubscriptionsUseCase,
       _checkSubscriptionStatusUseCase = checkSubscriptionStatusUseCase,
       _appsFlyerService = appsFlyerService,
       _talker = talker,
       super(const PaywallInitial()) {
    on<PaywallLoadProducts>(_onLoadProducts);
    on<PaywallPurchase>(_onPurchase);
    on<PaywallRestore>(_onRestore);
  }

  Future<void> _onLoadProducts(
    PaywallLoadProducts event,
    Emitter<PaywallState> emit,
  ) async {
    emit(const PaywallLoading());
    try {
      // Проверяем статус подписки (может не работать если AppHud не инициализирован)
      SubscriptionStatus? status;
      try {
        status = await _checkSubscriptionStatusUseCase();
      } catch (e) {
        _talker.warning('PaywallBloc: Failed to check subscription status: $e');
        status = null;
      }

      // Логируем событие (не критично, если AppsFlyer не инициализирован)
      try {
        await _appsFlyerService.logEvent('open_paywall', {
          'source_screen': 'paywall',
          'is_premium': status != null && status.toString().split('.').last == 'active',
        });
      } catch (e) {
        _talker.warning('PaywallBloc: Failed to log event: $e');
      }

      // Загружаем продукты (должны вернуться тестовые, если AppHud не инициализирован)
      final products = await _getPaywallProductsUseCase();
      _lastProducts = products;
      _talker.debug('PaywallBloc: Loaded ${products.length} products');
      
      // Если продукты пустые, это ошибка - должны быть хотя бы тестовые
      if (products.isEmpty) {
        _talker.warning(
          'PaywallBloc: No products found. Check AppHud configuration.',
        );
        emit(PaywallError(
          'No products available. Please check your internet connection and try again.',
        ));
        return;
      }
      
      emit(PaywallLoaded(products));
    } catch (e, stackTrace) {
      _talker.error('Failed to load paywall products', e, stackTrace);
      
      // Улучшенная обработка ошибок
      String errorMessage;
      final errorString = e.toString().toLowerCase();
      
      if (errorString.contains('network') ||
          errorString.contains('connection') ||
          errorString.contains('timeout') ||
          errorString.contains('socket')) {
        errorMessage = 'No internet connection. Please check your network and try again.';
      } else if (errorString.contains('products not available') ||
                 errorString.contains('products are not configured')) {
        errorMessage = 'Products are temporarily unavailable. Please try again later.';
      } else {
        errorMessage = 'Failed to load products. Please check your internet connection and try again.';
      }
      
      // Если есть сохраненные продукты, показываем их вместо ошибки
      if (_lastProducts.isNotEmpty) {
        _talker.info('PaywallBloc: Using cached products due to error');
        emit(PaywallLoaded(_lastProducts));
      } else {
        emit(PaywallError(errorMessage));
      }
    }
  }

  Future<void> _onPurchase(
    PaywallPurchase event,
    Emitter<PaywallState> emit,
  ) async {
    emit(PaywallPurchasing(event.product));
    try {
      await _purchaseSubscriptionUseCase(event.product);
      await _appsFlyerService.logEvent('subscription_purchased', {
        'source_screen': 'paywall',
        'product_id': event.product.id,
        'is_premium': true,
      });
      emit(const PaywallPurchaseSuccess());
    } catch (e, stackTrace) {
      _talker.error('Failed to purchase product', e, stackTrace);

      // Извлекаем понятное сообщение об ошибке
      String errorMessage = 'Purchase failed';
      final errorString = e.toString();

      if (errorString.contains('StoreKit Products Not Available') ||
          errorString.contains('not configured in App Store Connect')) {
        errorMessage =
            'Products are not configured yet.\n'
            'Please configure in-app purchases in App Store Connect.';
      } else if (errorString.contains('not found')) {
        errorMessage =
            'Product not found.\n'
            'Please check AppHud configuration.';
      } else {
        // Берем сообщение из исключения, убирая лишнее
        final match = RegExp(
          r'Exception:\s*(.+?)(?:\n|$)',
        ).firstMatch(errorString);
        if (match != null) {
          errorMessage = match.group(1) ?? errorMessage;
        } else {
          errorMessage = errorString.replaceAll('Exception: ', '');
        }
      }

      // Показываем ошибку через временное состояние, затем возвращаемся к продуктам
      if (_lastProducts.isNotEmpty) {
        // Сначала показываем ошибку, чтобы SnackBar отобразился
        emit(PaywallError(errorMessage));
        // Затем сразу возвращаемся к продуктам
        await Future.delayed(const Duration(milliseconds: 100));
        emit(PaywallLoaded(_lastProducts));
      } else {
        emit(PaywallError(errorMessage));
      }
    }
  }

  Future<void> _onRestore(
    PaywallRestore event,
    Emitter<PaywallState> emit,
  ) async {
    emit(const PaywallRestoring());
    try {
      await _restoreSubscriptionsUseCase();
      await _appsFlyerService.logEvent('subscription_restored', {
        'source_screen': 'paywall',
      });
      emit(const PaywallRestoreSuccess());
    } catch (e, stackTrace) {
      _talker.error('Failed to restore purchases', e, stackTrace);

      String errorMessage = 'Restore failed';
      final errorString = e.toString();
      final match = RegExp(
        r'Exception:\s*(.+?)(?:\n|$)',
      ).firstMatch(errorString);
      if (match != null) {
        errorMessage = match.group(1) ?? errorMessage;
      } else {
        errorMessage = errorString.replaceAll('Exception: ', '');
      }

      if (_lastProducts.isNotEmpty) {
        emit(PaywallError(errorMessage));
        await Future.delayed(const Duration(milliseconds: 100));
        emit(PaywallLoaded(_lastProducts));
      } else {
        emit(PaywallError(errorMessage));
      }
    }
  }
}
