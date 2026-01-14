import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:qr_scanner/features/splash/presentation/widgets/animated_background.dart';
import 'package:qr_scanner/features/splash/presentation/widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _canNavigate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _canNavigate = true;
        });
        context.read<OnboardingBloc>().add(const CheckOnboardingStatus());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
        if (!_canNavigate) return;
        if (state is OnboardingCompleted) {
          context.go('/scan-qr');
        } else if (state is OnboardingNotCompleted) {
          context.go('/onboarding');
        } else if (state is OnboardingError) {
            context.go('/onboarding');
          }
        },
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Stack(
            children: [
              const AnimatedBackground(),
              const SplashContent(),
                if (state is OnboardingChecking)
                  Container(
                    color: AppColors.whiteColor.withOpacity(0.8),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
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
          );
        },
      ),
    );
  }
}
