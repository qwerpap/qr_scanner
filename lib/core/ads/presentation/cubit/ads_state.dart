import 'package:equatable/equatable.dart';

/// Состояния для работы с рекламой.
abstract class AdsState extends Equatable {
  const AdsState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние.
class AdsInitial extends AdsState {
  const AdsInitial();
}

/// Реклама загружается.
class AdsLoading extends AdsState {
  const AdsLoading();
}

/// Реклама загружена и готова к показу.
class AdsLoaded extends AdsState {
  const AdsLoaded();
}

/// Ошибка при загрузке или показе рекламы.
class AdsError extends AdsState {
  final String message;

  const AdsError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Реклама не может быть показана (пользователь имеет подписку).
class AdsDisabled extends AdsState {
  const AdsDisabled();
}
