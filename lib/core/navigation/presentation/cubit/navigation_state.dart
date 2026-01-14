import 'package:equatable/equatable.dart';

class NavigationState extends Equatable {
  final int currentIndex;
  final bool isDark;

  const NavigationState({
    required this.currentIndex,
    required this.isDark,
  });

  NavigationState copyWith({
    int? currentIndex,
    bool? isDark,
  }) {
    return NavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
      isDark: isDark ?? this.isDark,
    );
  }

  @override
  List<Object?> get props => [
        currentIndex,
        isDark,
      ];
}

