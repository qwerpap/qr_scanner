import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/features/onboarding/data/constants/onboarding_data.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:qr_scanner/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:qr_scanner/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:qr_scanner/features/onboarding/presentation/cubit/onboarding_state.dart'
    as cubit_state;
import 'package:qr_scanner/features/onboarding/presentation/widgets/onboarding_bottom_section.dart';
import 'package:qr_scanner/features/onboarding/presentation/widgets/onboarding_gradient_background.dart';
import 'package:qr_scanner/features/onboarding/presentation/widgets/onboarding_page_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) {
            context.go('/home');
          }
        },
        child: BlocBuilder<OnboardingCubit, cubit_state.OnboardingState>(
          builder: (context, state) {
            final currentScreen = OnboardingData.screens[state.currentIndex];

            return Scaffold(
              body: OnboardingGradientBackground(
                child: SafeArea(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            context.read<OnboardingCubit>().changePage(index);
                          },
                          itemCount: OnboardingData.screens.length,
                          itemBuilder: (context, index) {
                            return OnboardingPageContent(
                              screen: OnboardingData.screens[index],
                            );
                          },
                        ),
                      ),
                      OnboardingBottomSection(
                        currentScreen: currentScreen,
                        currentIndex: state.currentIndex,
                        totalScreens: OnboardingData.screens.length,
                        onNextPressed: () {
                          final cubit = context.read<OnboardingCubit>();
                          if (cubit.canGoNext()) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            context.read<OnboardingBloc>().add(
                              const CompleteOnboarding(),
                            );
                          }
                        },
                        onSkipPressed: () {
                          context.read<OnboardingBloc>().add(
                            const CompleteOnboarding(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
