import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Timer? _timer;

  void initialize() {
    if (state.isInitialized) return;

    emit(state.copyWith(isInitialized: true));

    _timer = Timer(const Duration(seconds: 2), () {
      emit(state.copyWith(shouldNavigate: true));
    });
  }


  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
