import 'dart:async';
import 'app_side_effect.dart';

class AppSideEffectController {
  final _sideEffectController = StreamController<AppSideEffect>.broadcast();

  Stream<AppSideEffect> get stream => _sideEffectController.stream;

  void emit(AppSideEffect sideEffect) {
    if (!_sideEffectController.isClosed) {
      _sideEffectController.add(sideEffect);
    }
  }

  void dispose() {
    if (!_sideEffectController.isClosed) {
      _sideEffectController.close();
    }
  }
}
