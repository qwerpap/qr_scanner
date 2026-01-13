import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/navigation/presentation/widgets/app_router.dart';
import 'package:qr_scanner/core/theme/app_theme.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_bloc.dart';

void main() {
  BlocProviders.setup();
  runApp(const MyApp());
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
