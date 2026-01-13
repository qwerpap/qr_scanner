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

final GetIt getIt = GetIt.instance;

class BlocProviders {
  BlocProviders._();

  static void setup() {
    _registerTalker();
    _registerNavigationCubit();
    _registerSplashCubit();
    _registerOnboardingCubit();
    _registerOnboardingBloc();
  }

  static void _registerTalker() {
    getIt.registerLazySingleton<Talker>(() => TalkerFlutter.init());
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
