import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../navigation/presentation/cubit/navigation_cubit.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/onboarding/data/datasources/onboarding_local_datasource.dart';
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../features/onboarding/domain/repositories/onboarding_repository.dart';
import '../../features/onboarding/domain/usecases/check_onboarding_completed_usecase.dart';
import '../../features/onboarding/domain/usecases/set_onboarding_completed_usecase.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/scan_qr/presentation/cubit/qr_scanner_cubit.dart';
import '../../features/scan_result/data/datasources/scan_result_local_datasource.dart';
import '../../features/scan_result/data/repositories/scan_result_repository_impl.dart';
import '../../features/scan_result/domain/repositories/scan_result_repository.dart';
import '../../features/scan_result/domain/usecases/detect_qr_code_type_usecase.dart';
import '../../features/scan_result/domain/usecases/save_qr_code_usecase.dart';
import '../../features/scan_result/presentation/bloc/scan_result_bloc.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_recent_activities_usecase.dart';
import '../../features/home/domain/usecases/get_saved_qr_codes_count_usecase.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/history/data/repositories/history_repository_impl.dart';
import '../../features/history/domain/repositories/history_repository.dart';
import '../../features/history/domain/usecases/clear_history_usecase.dart';
import '../../features/history/domain/usecases/delete_qr_code_usecase.dart';
import '../../features/history/domain/usecases/get_history_usecase.dart';
import '../../features/history/presentation/bloc/history_bloc.dart';
import '../../features/my_qr_codes/data/datasources/my_qr_codes_local_datasource.dart';
import '../../features/my_qr_codes/data/repositories/my_qr_codes_repository_impl.dart';
import '../../features/my_qr_codes/domain/repositories/my_qr_codes_repository.dart';
import '../../features/my_qr_codes/domain/usecases/delete_created_qr_code_usecase.dart';
import '../../features/my_qr_codes/domain/usecases/get_created_qr_codes_usecase.dart';
import '../../features/my_qr_codes/domain/usecases/save_created_qr_code_usecase.dart';
import '../../features/my_qr_codes/domain/usecases/search_created_qr_codes_usecase.dart';
import '../../features/my_qr_codes/domain/usecases/update_created_qr_code_usecase.dart';
import '../../features/my_qr_codes/presentation/bloc/my_qr_codes_bloc.dart';
import '../../features/create_qr/domain/usecases/generate_qr_code_usecase.dart';
import '../../features/create_qr/domain/usecases/validate_qr_code_data_usecase.dart';
import '../../features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import '../services/app_side_effect_controller.dart';
import '../subscription/apphud_service.dart';
import '../services/attribution/att_service.dart';
import '../services/attribution/appsflyer_service.dart';
import '../services/attribution/firebase_attribution_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../../features/paywall/domain/repositories/paywall_repository.dart';
import '../../features/paywall/data/repositories/paywall_repository_impl.dart';
import '../../features/paywall/domain/usecases/get_paywall_products_usecase.dart';
import '../../features/paywall/domain/usecases/purchase_subscription_usecase.dart';
import '../../features/paywall/domain/usecases/restore_subscriptions_usecase.dart';
import '../../features/paywall/domain/usecases/check_subscription_status_usecase.dart';
import '../../features/paywall/presentation/bloc/paywall_bloc.dart';
import '../ads/data/datasources/admob_datasource.dart';
import '../ads/data/repositories/ads_repository_impl.dart';
import '../ads/domain/repositories/ads_repository.dart';
import '../ads/domain/usecases/init_ads_usecase.dart';
import '../ads/domain/usecases/can_show_ads_usecase.dart';
import '../ads/domain/usecases/load_banner_ad_usecase.dart';
import '../ads/domain/usecases/load_interstitial_ad_usecase.dart';
import '../ads/domain/usecases/show_interstitial_ad_usecase.dart';
import '../ads/domain/usecases/load_rewarded_ad_usecase.dart';
import '../ads/domain/usecases/show_rewarded_ad_usecase.dart';
import '../ads/domain/usecases/load_app_open_ad_usecase.dart';
import '../ads/domain/usecases/show_app_open_ad_usecase.dart';
import '../ads/presentation/cubit/ads_cubit.dart';

final GetIt getIt = GetIt.instance;

class BlocProviders {
  BlocProviders._();

  static void setup() {
    _registerTalker();
    _registerAppSideEffectController();
    _registerAttService();
    _registerAppHudService();
    _registerAppsFlyerService();
    _registerFirebaseAttributionService();
    _registerNavigationCubit();
    _registerSplashCubit();
    _registerOnboardingCubit();
    _registerOnboardingBloc();
    _registerQrScannerCubit();
    _registerScanResultBloc();
    _registerHomeCubit();
    _registerHistoryBloc();
    _registerMyQrCodesBloc();
    _registerCreateQrCodeCubit();
    _registerPaywallBloc();
    _registerAdsModule();
  }

  static void _registerTalker() {
    getIt.registerLazySingleton<Talker>(() => TalkerFlutter.init());
  }

  static void _registerAppSideEffectController() {
    getIt.registerLazySingleton<AppSideEffectController>(
      () => AppSideEffectController(),
    );
  }

  static void _registerAttService() {
    getIt.registerLazySingleton<AttService>(
      () => AttServiceImpl(talker: getIt<Talker>()),
    );
  }

  static void _registerAppHudService() {
    getIt.registerLazySingleton<AppHudService>(
      () => AppHudServiceImpl(talker: getIt<Talker>()),
    );
  }

  static void _registerAppsFlyerService() {
    getIt.registerLazySingleton<AppsFlyerService>(
      () => AppsFlyerService(
        talker: getIt<Talker>(),
        attService: getIt<AttService>(),
      ),
    );
    
    // Устанавливаем AppHudService в AppsFlyerService после регистрации обоих
    // Используем registerFactoryParam или устанавливаем после setup
    final appsFlyerService = getIt<AppsFlyerService>();
    appsFlyerService.setAppHudService(getIt<AppHudService>());
  }

  static void _registerFirebaseAttributionService() {
    getIt.registerLazySingleton<FirebaseAnalytics>(
      () => FirebaseAnalytics.instance,
    );

    getIt.registerLazySingleton<FirebaseAttributionService>(
      () {
        final service = FirebaseAttributionService(
          analytics: getIt<FirebaseAnalytics>(),
          talker: getIt<Talker>(),
        );
        // Устанавливаем AppHudService после регистрации
        service.setAppHudService(getIt<AppHudService>());
        return service;
      },
    );
  }

  static void _registerNavigationCubit() {
    getIt.registerFactoryParam<NavigationCubit, String, bool>(
      (currentLocation, isDark) =>
          NavigationCubit(currentLocation: currentLocation, isDark: isDark),
    );
  }

  static void _registerSplashCubit() {
    getIt.registerFactory<SplashCubit>(() => SplashCubit());
  }

  static void _registerOnboardingCubit() {
    getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
  }

  static void _registerOnboardingBloc() {
    // Data layer
    getIt.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSource(talker: getIt<Talker>()),
    );

    // Repository
    getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(
        localDataSource: getIt<OnboardingLocalDataSource>(),
      ),
    );

    // Use cases
    getIt.registerLazySingleton<CheckOnboardingCompletedUseCase>(
      () => CheckOnboardingCompletedUseCase(
        repository: getIt<OnboardingRepository>(),
      ),
    );

    getIt.registerLazySingleton<SetOnboardingCompletedUseCase>(
      () => SetOnboardingCompletedUseCase(
        repository: getIt<OnboardingRepository>(),
      ),
    );

    getIt.registerLazySingleton<OnboardingBloc>(
      () => OnboardingBloc(
        checkOnboardingCompletedUseCase: getIt<CheckOnboardingCompletedUseCase>(),
        setOnboardingCompletedUseCase: getIt<SetOnboardingCompletedUseCase>(),
      ),
    );
  }

  static void _registerQrScannerCubit() {
    getIt.registerFactory<QrScannerCubit>(() => QrScannerCubit());
  }

  static void _registerScanResultBloc() {
    getIt.registerLazySingleton<ScanResultLocalDataSource>(
      () => ScanResultLocalDataSource(talker: getIt<Talker>()),
    );

    getIt.registerLazySingleton<ScanResultRepository>(
      () => ScanResultRepositoryImpl(
        localDataSource: getIt<ScanResultLocalDataSource>(),
      ),
    );

    getIt.registerLazySingleton<DetectQrCodeTypeUseCase>(
      () => DetectQrCodeTypeUseCase(),
    );

    getIt.registerLazySingleton<SaveQrCodeUseCase>(
      () => SaveQrCodeUseCase(getIt<ScanResultRepository>()),
    );

    getIt.registerFactory<ScanResultBloc>(
      () => ScanResultBloc(
        detectQrCodeTypeUseCase: getIt<DetectQrCodeTypeUseCase>(),
        saveQrCodeUseCase: getIt<SaveQrCodeUseCase>(),
        sideEffectController: getIt<AppSideEffectController>(),
      ),
    );
  }

  static void _registerHomeCubit() {
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(
        scanResultRepository: getIt<ScanResultRepository>(),
      ),
    );

    getIt.registerLazySingleton<GetRecentActivitiesUseCase>(
      () => GetRecentActivitiesUseCase(getIt<HomeRepository>()),
    );

    getIt.registerLazySingleton<GetSavedQrCodesCountUseCase>(
      () => GetSavedQrCodesCountUseCase(getIt<HomeRepository>()),
    );

    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(
        getRecentActivitiesUseCase: getIt<GetRecentActivitiesUseCase>(),
        getSavedQrCodesCountUseCase: getIt<GetSavedQrCodesCountUseCase>(),
      ),
    );
  }

  static void _registerHistoryBloc() {
    getIt.registerLazySingleton<HistoryRepository>(
      () => HistoryRepositoryImpl(
        scanResultRepository: getIt<ScanResultRepository>(),
      ),
    );

    getIt.registerLazySingleton<GetHistoryUseCase>(
      () => GetHistoryUseCase(getIt<HistoryRepository>()),
    );

    getIt.registerLazySingleton<DeleteQrCodeUseCase>(
      () => DeleteQrCodeUseCase(getIt<HistoryRepository>()),
    );

    getIt.registerLazySingleton<ClearHistoryUseCase>(
      () => ClearHistoryUseCase(getIt<HistoryRepository>()),
    );

    getIt.registerFactory<HistoryBloc>(
      () => HistoryBloc(
        getHistoryUseCase: getIt<GetHistoryUseCase>(),
        deleteQrCodeUseCase: getIt<DeleteQrCodeUseCase>(),
        clearHistoryUseCase: getIt<ClearHistoryUseCase>(),
      ),
    );
  }

  static void _registerMyQrCodesBloc() {
    getIt.registerLazySingleton<MyQrCodesLocalDataSource>(
      () => MyQrCodesLocalDataSource(talker: getIt<Talker>()),
    );

    getIt.registerLazySingleton<MyQrCodesRepository>(
      () => MyQrCodesRepositoryImpl(
        localDataSource: getIt<MyQrCodesLocalDataSource>(),
      ),
    );

    getIt.registerLazySingleton<GetCreatedQrCodesUseCase>(
      () => GetCreatedQrCodesUseCase(getIt<MyQrCodesRepository>()),
    );

    getIt.registerLazySingleton<SearchCreatedQrCodesUseCase>(
      () => SearchCreatedQrCodesUseCase(getIt<MyQrCodesRepository>()),
    );

    getIt.registerLazySingleton<DeleteCreatedQrCodeUseCase>(
      () => DeleteCreatedQrCodeUseCase(getIt<MyQrCodesRepository>()),
    );

    getIt.registerLazySingleton<SaveCreatedQrCodeUseCase>(
      () => SaveCreatedQrCodeUseCase(
        repository: getIt<MyQrCodesRepository>(),
        scanResultRepository: getIt<ScanResultRepository>(),
      ),
    );

    getIt.registerFactory<MyQrCodesBloc>(
      () => MyQrCodesBloc(
        getCreatedQrCodesUseCase: getIt<GetCreatedQrCodesUseCase>(),
        searchCreatedQrCodesUseCase: getIt<SearchCreatedQrCodesUseCase>(),
        deleteCreatedQrCodeUseCase: getIt<DeleteCreatedQrCodeUseCase>(),
      ),
    );
  }

  static void _registerCreateQrCodeCubit() {
    getIt.registerLazySingleton<GenerateQrCodeUseCase>(
      () => GenerateQrCodeUseCase(),
    );

    getIt.registerLazySingleton<ValidateQrCodeDataUseCase>(
      () => ValidateQrCodeDataUseCase(),
    );

    getIt.registerLazySingleton<UpdateCreatedQrCodeUseCase>(
      () => UpdateCreatedQrCodeUseCase(
        repository: getIt<MyQrCodesRepository>(),
        scanResultRepository: getIt<ScanResultRepository>(),
      ),
    );

    getIt.registerFactory<CreateQrCodeCubit>(
      () => CreateQrCodeCubit(
        generateQrCodeUseCase: getIt<GenerateQrCodeUseCase>(),
        validateQrCodeDataUseCase: getIt<ValidateQrCodeDataUseCase>(),
        saveCreatedQrCodeUseCase: getIt<SaveCreatedQrCodeUseCase>(),
        updateCreatedQrCodeUseCase: getIt<UpdateCreatedQrCodeUseCase>(),
      ),
    );
  }

  static void _registerPaywallBloc() {
    // Repository
    getIt.registerLazySingleton<PaywallRepository>(
      () => PaywallRepositoryImpl(
        appHudService: getIt<AppHudService>(),
        talker: getIt<Talker>(),
      ),
    );

    // Use cases
    getIt.registerLazySingleton<GetPaywallProductsUseCase>(
      () => GetPaywallProductsUseCase(getIt<PaywallRepository>()),
    );

    getIt.registerLazySingleton<PurchaseSubscriptionUseCase>(
      () => PurchaseSubscriptionUseCase(getIt<PaywallRepository>()),
    );

    getIt.registerLazySingleton<RestoreSubscriptionsUseCase>(
      () => RestoreSubscriptionsUseCase(getIt<PaywallRepository>()),
    );

    getIt.registerLazySingleton<CheckSubscriptionStatusUseCase>(
      () => CheckSubscriptionStatusUseCase(getIt<PaywallRepository>()),
    );

    // Bloc
    getIt.registerFactory<PaywallBloc>(
      () => PaywallBloc(
        getPaywallProductsUseCase: getIt<GetPaywallProductsUseCase>(),
        purchaseSubscriptionUseCase: getIt<PurchaseSubscriptionUseCase>(),
        restoreSubscriptionsUseCase: getIt<RestoreSubscriptionsUseCase>(),
        checkSubscriptionStatusUseCase: getIt<CheckSubscriptionStatusUseCase>(),
        appsFlyerService: getIt<AppsFlyerService>(),
        talker: getIt<Talker>(),
      ),
    );
  }

  static void _registerAdsModule() {
    // Data source
    getIt.registerLazySingleton<AdMobDataSource>(
      () => AdMobDataSource(talker: getIt<Talker>()),
    );

    // Repository
    getIt.registerLazySingleton<AdsRepository>(
      () => AdsRepositoryImpl(
        dataSource: getIt<AdMobDataSource>(),
        appHudService: getIt<AppHudService>(),
        talker: getIt<Talker>(),
      ),
    );

    // Use cases
    getIt.registerLazySingleton<InitAdsUseCase>(
      () => InitAdsUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<CanShowAdsUseCase>(
      () => CanShowAdsUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<LoadBannerAdUseCase>(
      () => LoadBannerAdUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<LoadInterstitialAdUseCase>(
      () => LoadInterstitialAdUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<ShowInterstitialAdUseCase>(
      () => ShowInterstitialAdUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<LoadRewardedAdUseCase>(
      () => LoadRewardedAdUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<ShowRewardedAdUseCase>(
      () => ShowRewardedAdUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<LoadAppOpenAdUseCase>(
      () => LoadAppOpenAdUseCase(getIt<AdsRepository>()),
    );

    getIt.registerLazySingleton<ShowAppOpenAdUseCase>(
      () => ShowAppOpenAdUseCase(getIt<AdsRepository>()),
    );

    // Cubit
    getIt.registerLazySingleton<AdsCubit>(
      () => AdsCubit(
        initAdsUseCase: getIt<InitAdsUseCase>(),
        canShowAdsUseCase: getIt<CanShowAdsUseCase>(),
        loadInterstitialAdUseCase: getIt<LoadInterstitialAdUseCase>(),
        showInterstitialAdUseCase: getIt<ShowInterstitialAdUseCase>(),
        loadRewardedAdUseCase: getIt<LoadRewardedAdUseCase>(),
        showRewardedAdUseCase: getIt<ShowRewardedAdUseCase>(),
        loadAppOpenAdUseCase: getIt<LoadAppOpenAdUseCase>(),
        showAppOpenAdUseCase: getIt<ShowAppOpenAdUseCase>(),
        adsRepository: getIt<AdsRepository>(),
        talker: getIt<Talker>(),
      ),
    );
  }

  static Widget wrapWithProviders({
    required BuildContext context,
    required Widget child,
  }) {
    final currentLocation = GoRouterState.of(context).uri.path;
    final brightness = MediaQuery.platformBrightnessOf(context);
    final isDark = brightness == Brightness.dark;

    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (_) =>
              getIt<NavigationCubit>(param1: currentLocation, param2: isDark),
        ),
        BlocProvider<AdsCubit>(
          create: (_) => getIt<AdsCubit>(),
        ),
      ],
      child: child,
    );
  }
}
