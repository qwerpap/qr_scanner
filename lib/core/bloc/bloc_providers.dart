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
import '../services/app_side_effect_controller.dart';

final GetIt getIt = GetIt.instance;

class BlocProviders {
  BlocProviders._();

  static void setup() {
    _registerTalker();
    _registerAppSideEffectController();
    _registerNavigationCubit();
    _registerSplashCubit();
    _registerOnboardingCubit();
    _registerOnboardingBloc();
    _registerQrScannerCubit();
    _registerScanResultBloc();
    _registerHomeCubit();
  }

  static void _registerTalker() {
    getIt.registerLazySingleton<Talker>(() => TalkerFlutter.init());
  }

  static void _registerAppSideEffectController() {
    getIt.registerLazySingleton<AppSideEffectController>(
      () => AppSideEffectController(),
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
      ],
      child: child,
    );
  }
}
