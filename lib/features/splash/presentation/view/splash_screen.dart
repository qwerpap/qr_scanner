import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:qr_scanner/features/splash/presentation/cubit/splash_state.dart';
import 'package:qr_scanner/features/splash/presentation/widgets/animated_background.dart';
import 'package:qr_scanner/features/splash/presentation/widgets/splash_content.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..initialize(),
      child: BlocListener<SplashCubit, SplashState>(
        listenWhen: (previous, current) => current.shouldNavigate,
        listener: (context, state) {
          if (state.shouldNavigate) {
            context.go('/onboarding');
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Stack(
            children: [
              const AnimatedBackground(),
              const SplashContent(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Center(
                      child: Text(
                        'Version 1.0.0',
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
