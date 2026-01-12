import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../utils/navigation_utils.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({
    required String currentLocation,
    required bool isDark,
  }) : super(
          NavigationState(
            currentIndex: NavigationUtils.getCurrentIndex(currentLocation),
            isDark: isDark,
          ),
        );

  void updateCurrentRoute(String currentLocation) {
    final newIndex = NavigationUtils.getCurrentIndex(currentLocation);
    if (newIndex != state.currentIndex) {
      emit(state.copyWith(currentIndex: newIndex));
    }
  }

  void updateTheme(bool isDark) {
    if (isDark != state.isDark) {
      emit(state.copyWith(isDark: isDark));
    }
  }

  void navigateToRoute(BuildContext context, String route) {
    context.go(route);
  }
}

