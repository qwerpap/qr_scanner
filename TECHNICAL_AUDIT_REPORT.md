# 🔍 ПОЛНЫЙ ТЕХНИЧЕСКИЙ АУДИТ Flutter-приложения qr_scanner

**Дата аудита:** 2025-01-27  
**Версия приложения:** 1.0.0+1  
**Аудитор:** Senior Mobile Engineer + App Store / Google Play Reviewer

---

## 📊 ТАБЛИЦА ПРОБЛЕМ

| # | Проблема | Платформа | Критичность | Файл | Описание |
|---|----------|-----------|-------------|------|----------|
| 1 | Отсутствует flutter_localizations | iOS/Android | **BLOCKER** | `pubspec.yaml` | Локализация не настроена, нет поддержки MaterialLocalizations/CupertinoLocalizations |
| 2 | Нет fallbackLocale | iOS/Android | **HIGH** | `lib/main.dart` | Приложение не имеет fallback локали при отсутствии перевода |
| 3 | Hardcoded строки в UI | iOS/Android | **HIGH** | Множество файлов | Все строки захардкожены, нет локализации |
| 4 | Hardcoded строки в Paywall | iOS/Android | **HIGH** | `lib/features/paywall/` | Все тексты paywall захардкожены |
| 5 | Hardcoded строки в диалогах | iOS/Android | **HIGH** | `lib/core/shared/widgets/custom_dialog.dart` | Диалоги не локализованы |
| 6 | NSUserTrackingUsageDescription отсутствует | iOS | **BLOCKER** | `ios/Runner/Info.plist` | Обязательный ключ для ATT отсутствует - App Store отклонит |
| 7 | ATT вызывается до AppsFlyer start() | iOS | **MEDIUM** | `lib/main.dart` | Порядок инициализации может нарушить AppsFlyer attribution |
| 8 | setWaitForATTUserAuthorization не используется | iOS | **MEDIUM** | `lib/core/services/attribution/appsflyer_service.dart` | AppsFlyer не настроен на ожидание ATT |
| 9 | INTERNET permission только в debug/profile | Android | **MEDIUM** | `android/app/src/main/AndroidManifest.xml` | Нет INTERNET в main манифесте |
| 10 | ACCESS_NETWORK_STATE отсутствует | Android | **LOW** | `android/app/src/main/AndroidManifest.xml` | Рекомендуется для AppsFlyer |
| 11 | Freepik API ключ в требованиях, но не используется | iOS/Android | **LOW** | - | Ключ указан в ТЗ, но нет реализации |
| 12 | debugPrint в production коде | iOS/Android | **MEDIUM** | `lib/main.dart`, `lib/features/scan_qr/` | debugPrint должен быть только в debug |
| 13 | Тестовые продукты в production | iOS/Android | **HIGH** | `lib/core/subscription/apphud_service.dart` | Fallback на тестовые продукты может скрыть проблемы |
| 14 | Нет обработки grace period | iOS/Android | **MEDIUM** | `lib/core/subscription/apphud_service.dart` | Не проверяется isIntro/isTrial |
| 15 | Нет обработки ошибок StoreKit при restore без сети | iOS | **MEDIUM** | `lib/core/subscription/apphud_service.dart` | Может упасть при отсутствии сети |
| 16 | SafeArea поверх BottomNavigation | iOS/Android | **LOW** | `lib/core/navigation/presentation/widgets/bottom_navigation.dart` | Может вызвать проблемы на устройствах с жестовой навигацией |
| 17 | Hardcoded цены в тестовых продуктах | iOS/Android | **MEDIUM** | `lib/core/subscription/apphud_service.dart` | Тестовые продукты имеют USD цены |
| 18 | Нет проверки на первый запуск для AppsFlyer | iOS/Android | **LOW** | `lib/core/services/attribution/appsflyer_service.dart` | is_first_launch не обрабатывается |
| 19 | Apple Search Ads не передается в AppHud | iOS | **MEDIUM** | `lib/core/services/attribution/appsflyer_service.dart` | Данные есть, но не передаются корректно |
| 20 | Нет обработки ошибок при отсутствии интернета | iOS/Android | **MEDIUM** | `lib/features/paywall/presentation/bloc/paywall_bloc.dart` | Может показать неинформативную ошибку |

---

## 🔧 КОНКРЕТНЫЕ ИСПРАВЛЕНИЯ

### 1️⃣ ЛОКАЛИЗАЦИЯ

#### Проблема 1-5: Отсутствует локализация

**Файл:** `pubspec.yaml`

**Исправление:**
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2  # уже есть
```

**Файл:** `lib/main.dart`

**Исправление:**
```dart
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => getIt<OnboardingBloc>(),
      child: MaterialApp.router(
        title: 'QR Scanner',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: AppRouter.router,
        // ДОБАВИТЬ:
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('ru', ''), // Russian
          Locale('es', ''), // Spanish
        ],
        locale: const Locale('en', ''), // fallback
      ),
    );
  }
}
```

**Создать файлы локализации:**
- `lib/l10n/app_en.arb`
- `lib/l10n/app_ru.arb`
- `lib/l10n/app_es.arb`

**Пример `app_en.arb`:**
```json
{
  "@@locale": "en",
  "appTitle": "QR Scanner",
  "@appTitle": {
    "description": "Application title"
  },
  "paywallTitle": "Unlock Full QR Tools",
  "paywallSubtitle": "Unlimited scans, custom QR creation, and full history access.",
  "continue": "Continue",
  "restorePurchases": "Restore Purchases",
  "termsOfService": "Terms of Service",
  "privacyPolicy": "Privacy Policy",
  "subscriptionPurchasedSuccessfully": "Subscription purchased successfully!",
  "purchasesRestoredSuccessfully": "Purchases restored successfully!",
  "autoRenewableCancelAnytime": "Auto-renewable. Cancel anytime."
}
```

**Заменить все hardcoded строки на:**
```dart
// Было:
Text('Continue')

// Стало:
Text(context.l10n.continue)
```

---

### 2️⃣ ATT (iOS) - КРИТИЧНО

#### Проблема 6: NSUserTrackingUsageDescription отсутствует

**Файл:** `ios/Runner/Info.plist`

**Исправление:**
```xml
<key>NSUserTrackingUsageDescription</key>
<string>We use your data to provide personalized ads and improve our services. Your privacy is important to us.</string>
```

**⚠️ ВАЖНО:** Текст должен соответствовать реальному использованию данных. Если приложение не показывает рекламу, текст должен быть другим.

---

#### Проблема 7: Порядок инициализации ATT

**Файл:** `lib/main.dart`

**Текущий код (строки 74-105):**
```dart
// Запрашиваем ATT с задержкой (после инициализации AppsFlyer)
try {
  final attService = getIt<AttService>();
  final appsFlyerService = getIt<AppsFlyerService>();
  final attStatus = await attService.getStatus();
  if (attStatus == AttStatus.notDetermined) {
    await Future.delayed(const Duration(seconds: 1));
    final newAttStatus = await attService.requestPermission();
    // ...
  }
}
```

**Проблема:** AppsFlyer должен быть настроен на ожидание ATT ДО запроса разрешения.

**Исправление:**
```dart
// 1. Сначала инициализируем AppsFlyer с setWaitForATTUserAuthorization
try {
  final appsFlyerService = getIt<AppsFlyerService>();
  await appsFlyerService.init(); // init() должен использовать setWaitForATTUserAuthorization
  // ...
} catch (e) {
  debugPrint('AppsFlyer error: $e');
}

// 2. ТОЛЬКО ПОСЛЕ этого запрашиваем ATT
try {
  final attService = getIt<AttService>();
  final attStatus = await attService.getStatus();
  if (attStatus == AttStatus.notDetermined) {
    await Future.delayed(const Duration(seconds: 1));
    final newAttStatus = await attService.requestPermission();
    // После получения статуса - запускаем AppsFlyer start()
    await appsFlyerService.start(); // если есть такой метод
  }
} catch (e) {
  debugPrint('ATT error: $e');
}
```

---

#### Проблема 8: setWaitForATTUserAuthorization не используется

**Файл:** `lib/core/services/attribution/appsflyer_service.dart`

**Исправление:**
```dart
@override
Future<void> init() async {
  if (_isInitialized) {
    _talker.debug('AppsFlyer already initialized');
    return;
  }

  try {
    final appsFlyerOptions = AppsFlyerOptions(
      afDevKey: _devKey,
      appId: _appleAppId,
      showDebug: true,
      // ДОБАВИТЬ для iOS:
      timeToWaitForATTUserAuthorization: 60, // секунды ожидания ATT
    );

    _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    await _appsflyerSdk!.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
      // ДОБАВИТЬ:
      waitForATTUserAuthorization: true, // если поддерживается
    );
    // ...
  }
}
```

**⚠️ ПРОВЕРИТЬ:** Документацию `appsflyer_sdk: ^6.17.8` на наличие параметра `waitForATTUserAuthorization` в `initSdk()`.

---

### 3️⃣ ANDROID PERMISSIONS

#### Проблема 9-10: Отсутствуют разрешения

**Файл:** `android/app/src/main/AndroidManifest.xml`

**Исправление:**
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.CAMERA"/>
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
    <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
    <!-- ДОБАВИТЬ: -->
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <!-- ... -->
</manifest>
```

---

### 4️⃣ APPHUD - УЛУЧШЕНИЯ

#### Проблема 13: Тестовые продукты в production

**Файл:** `lib/core/subscription/apphud_service.dart`

**Исправление:**
```dart
@override
Future<List<SubscriptionProduct>> getPaywallProducts() async {
  try {
    // ...
    if (allProducts.isEmpty) {
      _talker.warning('AppHud: No products found.');
      // В PRODUCTION не возвращать тестовые продукты
      // Только в DEBUG режиме
      if (kDebugMode) {
        _hasRealProducts = false;
        final testProducts = _getTestProducts();
        _talker.debug('AppHud: Returning ${testProducts.length} test products (DEBUG MODE)');
        return testProducts;
      } else {
        // В production возвращаем пустой список или показываем ошибку
        throw Exception('Products are not available. Please check your internet connection.');
      }
    }
    // ...
  }
}
```

**Добавить импорт:**
```dart
import 'package:flutter/foundation.dart';
```

---

#### Проблема 14: Нет обработки grace period

**Файл:** `lib/core/subscription/apphud_service.dart`

**Исправление:**
```dart
@override
Future<SubscriptionStatus> getSubscriptionStatus() async {
  try {
    if (_hasTestSubscription) {
      return SubscriptionStatus.active;
    }
    
    final hasActiveSubscription = await Apphud.hasActiveSubscription();
    
    // ДОБАВИТЬ проверку grace period, trial, intro
    // Проверяем через subscriptions list
    final subscriptions = await Apphud.subscriptions();
    bool isActive = false;
    bool isInGracePeriod = false;
    bool isTrial = false;
    bool isIntro = false;
    
    for (final sub in subscriptions) {
      if (sub.isActive()) {
        isActive = true;
        // Проверяем дополнительные статусы
        // isInGracePeriod, isTrial, isIntro - если доступны в SDK
      }
    }
    
    // Если в grace period, считаем активной
    if (isInGracePeriod) {
      return SubscriptionStatus.active;
    }
    
    return isActive ? SubscriptionStatus.active : SubscriptionStatus.inactive;
  } catch (e, stackTrace) {
    _talker.error('AppHud: Failed to get subscription status', e, stackTrace);
    return SubscriptionStatus.unknown;
  }
}
```

**⚠️ ПРОВЕРИТЬ:** Документацию AppHud SDK на наличие методов для проверки grace period, trial, intro.

---

#### Проблема 15: Обработка ошибок при restore без сети

**Файл:** `lib/core/subscription/apphud_service.dart`

**Исправление:**
```dart
@override
Future<void> restore() async {
  try {
    _talker.debug('AppHud: Starting restore purchases');

    final result = await Apphud.restorePurchases().timeout(
      const Duration(seconds: 30), // таймаут для сети
      onTimeout: () {
        throw TimeoutException('Restore timeout: no internet connection');
      },
    );

    if (result.error != null) {
      final error = result.error!;
      _talker.error('AppHud: Restore failed: ${error.message}', error);
      
      // Специфичная обработка ошибок сети
      if (error.message?.toLowerCase().contains('network') == true ||
          error.message?.toLowerCase().contains('connection') == true) {
        throw Exception('No internet connection. Please check your network and try again.');
      }
      
      throw Exception('Restore failed: ${error.message}');
    }

    _talker.debug('AppHud: Restore completed successfully');
    final newStatus = await getSubscriptionStatus();
    notifySubscriptionChanged(newStatus);
  } on TimeoutException catch (e) {
    _talker.error('AppHud: Restore timeout', e);
    throw Exception('Restore timeout. Please check your internet connection.');
  } catch (e, stackTrace) {
    _talker.error('AppHud: Restore error', e, stackTrace);
    rethrow;
  }
}
```

**Добавить импорт:**
```dart
import 'dart:async';
```

---

### 5️⃣ LOGGING & DEBUG

#### Проблема 12: debugPrint в production

**Файл:** `lib/main.dart`, `lib/features/scan_qr/presentation/cubit/qr_scanner_cubit.dart`

**Исправление:**
```dart
// Заменить все debugPrint на:
import 'package:flutter/foundation.dart';

// Использовать:
if (kDebugMode) {
  debugPrint('AppHud initialized');
}

// Или использовать Talker (уже есть в проекте):
_talker.debug('AppHud initialized');
```

**Файлы для исправления:**
- `lib/main.dart` (строки 24, 28, 35, 49, 51, 60, 62, 69, 71, 83, 89, 91, 98, 100, 104)
- `lib/features/scan_qr/presentation/cubit/qr_scanner_cubit.dart` (строки 104, 113, 139)
- `lib/core/shared/widgets/qr_code_section.dart` (строка 77)

---

### 6️⃣ APPSFLYER - УЛУЧШЕНИЯ

#### Проблема 18-19: Обработка Apple Search Ads и первого запуска

**Файл:** `lib/core/services/attribution/appsflyer_service.dart`

**Исправление:**
```dart
void _setupCallbacks() {
  _appsflyerSdk?.onInstallConversionData((data) {
    _talker.debug('AppsFlyer: Conversion data received: $data');
    
    if (_appHudService != null && data != null) {
      final attributionData = <String, String>{};
      
      if (data is Map) {
        final mediaSource = data['media_source']?.toString();
        final campaign = data['campaign']?.toString();
        final afStatus = data['af_status']?.toString();
        final isFirstLaunch = data['is_first_launch']?.toString();
        
        // УЛУЧШЕННАЯ проверка Apple Search Ads
        final isSearchAds = data['is_search_ads']?.toString() == 'true' ||
            mediaSource?.toLowerCase() == 'searchads' ||
            mediaSource?.toLowerCase().contains('apple_search_ads') == true ||
            campaign?.toLowerCase().contains('searchads') == true;
        
        if (mediaSource != null) {
          attributionData['media_source'] = mediaSource;
        }
        if (campaign != null) {
          attributionData['campaign'] = campaign;
        }
        if (afStatus != null) {
          attributionData['af_status'] = afStatus;
        }
        // ДОБАВИТЬ обработку первого запуска
        if (isFirstLaunch != null) {
          attributionData['is_first_launch'] = isFirstLaunch;
        }
        if (isSearchAds) {
          attributionData['is_apple_search_ads'] = 'true';
          attributionData['source'] = 'apple_search_ads'; // Явно указываем источник
          _talker.debug('AppsFlyer: Apple Search Ads detected');
        } else {
          attributionData['source'] = 'appsflyer';
        }
        
        // Передаем в AppHud
        _attService.getStatus().then((attStatus) {
          attributionData['att_status'] = attStatus.toString().split('.').last;
          
          _appHudService!.setAttribution(attributionData);
          _talker.debug('AppsFlyer: Attribution data sent to AppHud: $attributionData');
        });
      }
    }
  });
  // ...
}
```

---

### 7️⃣ UI/UX - SAFE AREA

#### Проблема 16: SafeArea поверх BottomNavigation

**Файл:** `lib/core/navigation/presentation/widgets/bottom_navigation.dart`

**Текущий код правильный** - используется `SafeArea(top: false)` что корректно для bottom navigation.

**Проверить:** На устройствах с жестовой навигацией (Android) и Dynamic Island (iOS) все элементы должны быть видны.

---

### 8️⃣ ERROR HANDLING

#### Проблема 20: Обработка ошибок сети

**Файл:** `lib/features/paywall/presentation/bloc/paywall_bloc.dart`

**Исправление:**
```dart
Future<void> _onLoadProducts(
  PaywallLoadProducts event,
  Emitter<PaywallState> emit,
) async {
  emit(const PaywallLoading());
  try {
    // ...
    final products = await _getPaywallProductsUseCase();
    // ...
  } catch (e, stackTrace) {
    _talker.error('Failed to load paywall products', e, stackTrace);
    
    // УЛУЧШЕННАЯ обработка ошибок
    String errorMessage;
    if (e.toString().toLowerCase().contains('network') ||
        e.toString().toLowerCase().contains('connection') ||
        e.toString().toLowerCase().contains('timeout')) {
      errorMessage = 'No internet connection. Please check your network and try again.';
    } else if (e.toString().toLowerCase().contains('products not available')) {
      errorMessage = 'Products are temporarily unavailable. Please try again later.';
    } else {
      errorMessage = 'Failed to load products. Please check your internet connection and try again.';
    }
    
    if (_lastProducts.isNotEmpty) {
      _talker.info('PaywallBloc: Using cached products due to error');
      emit(PaywallLoaded(_lastProducts));
      // Показываем snackbar с предупреждением
      // (через BlocListener в UI)
    } else {
      emit(PaywallError(errorMessage));
    }
  }
}
```

---

## 📋 ДОПОЛНИТЕЛЬНЫЕ РЕКОМЕНДАЦИИ

### 1. Freepik API
- Ключ указан в ТЗ, но не используется
- **Рекомендация:** Если не планируется использовать, удалить из ТЗ. Если планируется - реализовать с правильной обработкой ошибок и таймаутами.

### 2. Тестирование на реальных устройствах
- **Обязательно протестировать:**
  - iPhone SE / mini (маленький экран)
  - iPhone Pro Max (большой экран)
  - iPhone с Dynamic Island
  - Android с жестовой навигацией
  - Android с cutout/notch

### 3. App Store Connect / Google Play Console
- **Перед публикацией проверить:**
  - Все разрешения имеют описания
  - Privacy Policy и Terms of Service ссылки работают
  - Подписки настроены в App Store Connect / Google Play Console
  - Тестовые аккаунты созданы

### 4. Edge Cases
- **Проверить:**
  - Первый запуск без интернета
  - Покупка → kill app → reopen
  - Восстановление без активной покупки
  - Смена Apple ID
  - Grace period подписки

---

## ✅ ФИНАЛЬНЫЙ ВЕРДИКТ

### 🚫 **НЕ ГОТОВО** к продакшену

### Критические блокеры:
1. ❌ **NSUserTrackingUsageDescription отсутствует** - App Store отклонит приложение
2. ❌ **Локализация не настроена** - все строки захардкожены
3. ❌ **flutter_localizations не подключен** - нет поддержки локализации

### Обязательные исправления перед релизом:
1. ✅ Добавить `NSUserTrackingUsageDescription` в `Info.plist`
2. ✅ Настроить локализацию (flutter_localizations + файлы локализации)
3. ✅ Заменить все hardcoded строки на локализованные
4. ✅ Исправить порядок инициализации ATT/AppsFlyer
5. ✅ Добавить INTERNET permission в Android манифест
6. ✅ Убрать debugPrint из production кода
7. ✅ Улучшить обработку ошибок сети

### Рекомендуемые улучшения:
1. ⚠️ Добавить setWaitForATTUserAuthorization для AppsFlyer
2. ⚠️ Улучшить обработку grace period в AppHud
3. ⚠️ Добавить таймауты для restore purchases
4. ⚠️ Улучшить обработку Apple Search Ads

### После исправлений:
- ✅ Провести полное тестирование на реальных устройствах
- ✅ Протестировать все edge cases
- ✅ Проверить работу подписок в sandbox/test окружении
- ✅ Убедиться, что все ссылки (Privacy Policy, Terms) работают

---

**Оценка времени на исправление:** 2-3 дня разработки + 1 день тестирования

**Приоритет исправлений:**
1. **КРИТИЧНО (1 день):** NSUserTrackingUsageDescription, локализация базовая
2. **ВЫСОКИЙ (1 день):** Порядок инициализации SDK, Android permissions, debugPrint
3. **СРЕДНИЙ (0.5 дня):** Улучшения обработки ошибок, edge cases
