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
    _registerHistoryBloc();
    _registerMyQrCodesBloc();
    _registerCreateQrCodeCubit();
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
