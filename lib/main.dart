import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Инициализация с обработкой всех ошибок
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint('Flutter Error: ${details.exception}');
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Platform Error: $error');
    return true;
  };

  try {
  BlocProviders.setup();
  } catch (e, stackTrace) {
    debugPrint('BlocProviders setup error: $e\n$stackTrace');
  }

  // Инициализация SDK в фоне (не блокируем запуск)
  _initializeSDKsInBackground();

  runApp(const MyApp());
}

void _initializeSDKsInBackground() {
  // Запускаем инициализацию асинхронно, не ждем завершения
  Future.microtask(() async {
    try {
      await getIt<AppHudService>().init();
      debugPrint('AppHud initialized');
    } catch (e) {
      debugPrint('AppHud error: $e');
    }

    try {
      final appsFlyerService = getIt<AppsFlyerService>();
      await appsFlyerService.init();
      // Данные конверсии будут переданы автоматически через callback
      final attributionData = await appsFlyerService.getAttributionData();
      await getIt<AppHudService>().setAttribution(attributionData);
      debugPrint('AppsFlyer initialized');
    } catch (e) {
      debugPrint('AppsFlyer error: $e');
    }

    // Отправляем данные атрибуции из Firebase в AppHud
    try {
      final firebaseAttributionService = getIt<FirebaseAttributionService>();
      await firebaseAttributionService.sendAttributionToAppHud();
      debugPrint('Firebase attribution sent to AppHud');
    } catch (e) {
      debugPrint('Firebase attribution error: $e');
    }

    // Запрашиваем ATT с задержкой (после инициализации AppsFlyer)
    try {
      final attService = getIt<AttService>();
      final attStatus = await attService.getStatus();
      if (attStatus == AttStatus.notDetermined) {
        // Задержка перед запросом ATT (рекомендуется 1-2 секунды после запуска)
        await Future.delayed(const Duration(seconds: 1));
        await attService.requestPermission();
        final newAttStatus = await attService.getStatus();
        debugPrint('ATT status: $newAttStatus');
      }
    } catch (e) {
      debugPrint('ATT error: $e');
    }
  });
}

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
      ),
    );
  }
}
