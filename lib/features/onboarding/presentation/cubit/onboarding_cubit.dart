import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/navigation/data/constants/navigation_constants.dart';
import '../../data/constants/onboarding_data.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void changePage(int index) {
    if (index != state.currentIndex) {
      emit(state.copyWith(currentIndex: index));
    }
  }

  bool canGoNext(BuildContext context) {
    return state.currentIndex < OnboardingData.getScreens(context).length - 1;
  }

  bool isLastPage(BuildContext context) {
    return state.currentIndex == OnboardingData.getScreens(context).length - 1;
  }

  void navigateToHome(BuildContext context) {
    context.go(NavigationConstants.home);
  }
}
