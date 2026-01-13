import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final bool isInitialized;
  final bool shouldNavigate;

  const SplashState({
    this.isInitialized = false,
    this.shouldNavigate = false,
  });

  SplashState copyWith({
    bool? isInitialized,
    bool? shouldNavigate,
  }) {
    return SplashState(
      isInitialized: isInitialized ?? this.isInitialized,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
    );
  }

  @override
  List<Object?> get props => [isInitialized, shouldNavigate];
}
