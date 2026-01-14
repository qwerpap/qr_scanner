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
            currentIndex: NavigationUtils.getCurrentIndex(currentLocation) ?? 0,
            isDark: isDark,
          ),
        );

  void updateCurrentRoute(String currentLocation) {
    final newIndex = NavigationUtils.getCurrentIndex(currentLocation);
    // Only update if route is a main navigation tab (not null)
    if (newIndex != null && newIndex != state.currentIndex) {
      emit(state.copyWith(currentIndex: newIndex));
    }
  }

  void updateTheme(bool isDark) {
    if (isDark != state.isDark) {
      emit(state.copyWith(isDark: isDark));
    }
  }

  void navigateToRoute(BuildContext context, String route) {
    final newIndex = NavigationUtils.getCurrentIndex(route);
    // Only update index if route is a main navigation tab
    if (newIndex != null && newIndex != state.currentIndex) {
      emit(state.copyWith(currentIndex: newIndex));
    }
    context.go(route);
  }
}

