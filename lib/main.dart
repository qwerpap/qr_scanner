import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/navigation/presentation/widgets/app_router.dart';
import 'package:qr_scanner/core/theme/app_theme.dart';
import 'package:qr_scanner/core/subscription/apphud_service.dart';
import 'package:qr_scanner/core/services/attribution/appsflyer_service.dart';
import 'package:qr_scanner/core/services/attribution/firebase_attribution_service.dart';
import 'package:qr_scanner/core/services/attribution/att_service.dart';
import 'package:qr_scanner/core/services/attribution/att_status.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:qr_scanner/firebase_options.dart';
import 'package:qr_scanner/core/services/user_preferences_service.dart';
import 'package:qr_scanner/core/l10n/locale_provider.dart';
import 'package:qr_scanner/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Инициализация с обработкой всех ошибок
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kDebugMode) {
      debugPrint('Flutter Error: ${details.exception}');
    }
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    if (kDebugMode) {
      debugPrint('Platform Error: $error');
    }
    return true;
  };

  try {
    BlocProviders.setup();
  } catch (e, stackTrace) {
    if (kDebugMode) {
      debugPrint('BlocProviders setup error: $e\n$stackTrace');
    }
  }

  // Инициализация SDK в фоне (не блокируем запуск)
  _initializeSDKsInBackground();

  runApp(const MyApp());
}

void _initializeSDKsInBackground() {
  // Запускаем инициализацию асинхронно, не ждем завершения
  Future.microtask(() async {
    // 1. Инициализируем AppHud
    try {
      await getIt<AppHudService>().init();
      if (kDebugMode) {
        debugPrint('AppHud initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AppHud error: $e');
      }
    }

    // 2. Инициализируем AppsFlyer (БЕЗ запуска start, только init)
    // AppsFlyer должен быть готов к получению ATT статуса
    final appsFlyerService = getIt<AppsFlyerService>();
    try {
      await appsFlyerService.init();
      if (kDebugMode) {
        debugPrint('AppsFlyer initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AppsFlyer error: $e');
      }
    }

    // 3. Отправляем данные атрибуции из Firebase в AppHud
    try {
      final firebaseAttributionService = getIt<FirebaseAttributionService>();
      await firebaseAttributionService.sendAttributionToAppHud();
      if (kDebugMode) {
        debugPrint('Firebase attribution sent to AppHud');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Firebase attribution error: $e');
      }
    }

    // 4. Запрашиваем ATT (ПОСЛЕ инициализации AppsFlyer, но ДО start)
    // Правильный порядок: init AppsFlyer → request ATT → start AppsFlyer (если нужно)
    try {
      final attService = getIt<AttService>();
      final attStatus = await attService.getStatus();

      if (attStatus == AttStatus.notDetermined) {
        // Задержка перед запросом ATT (рекомендуется 1-2 секунды после запуска)
        await Future.delayed(const Duration(seconds: 1));
        final newAttStatus = await attService.requestPermission();

        if (kDebugMode) {
          debugPrint('ATT status: $newAttStatus');
        }

        // Передаем обновленный ATT статус в AppsFlyer SDK
        try {
          final attStatusString = newAttStatus.toString().split('.').last;
          await appsFlyerService.setUserData({'att_status': attStatusString});
          if (kDebugMode) {
            debugPrint('ATT status sent to AppsFlyer: $attStatusString');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Failed to send ATT status to AppsFlyer: $e');
          }
        }
      } else {
        // Если статус уже определен, передаем его в AppsFlyer
        try {
          final attStatusString = attStatus.toString().split('.').last;
          await appsFlyerService.setUserData({'att_status': attStatusString});
          if (kDebugMode) {
            debugPrint('ATT status sent to AppsFlyer: $attStatusString');
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Failed to send ATT status to AppsFlyer: $e');
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ATT error: $e');
      }
    }

    // 5. Передаем данные конверсии из AppsFlyer в AppHud (после ATT)
    try {
      final attributionData = await appsFlyerService.getAttributionData();
      await getIt<AppHudService>().setAttribution(attributionData);
      if (kDebugMode) {
        debugPrint('AppsFlyer attribution data sent to AppHud');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to send AppsFlyer attribution to AppHud: $e');
      }
    }
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');
  final UserPreferencesService _userPreferencesService =
      UserPreferencesService();

  @override
  void initState() {
    super.initState();
    _loadSavedLocale();
  }

  Future<void> _loadSavedLocale() async {
    final savedLocale = await _userPreferencesService.getSavedLocale();
    if (savedLocale != null && mounted) {
      setState(() {
        _locale = savedLocale;
      });
    }
  }

  void updateLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
    _userPreferencesService.setSavedLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => getIt<OnboardingBloc>(),
      child: LocaleProvider(
        onLocaleChanged: updateLocale,
        child: _AppWithLocale(locale: _locale, onLocaleChanged: updateLocale),
      ),
    );
  }
}

class _AppWithLocale extends StatelessWidget {
  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  const _AppWithLocale({required this.locale, required this.onLocaleChanged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'QR Master',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter.router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('ru')],
      locale: locale,
    );
  }
}
