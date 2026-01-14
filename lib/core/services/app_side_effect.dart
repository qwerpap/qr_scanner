import 'package:equatable/equatable.dart';
import 'notification_type.dart';

sealed class AppSideEffect extends Equatable {
  const AppSideEffect();

  @override
  List<Object?> get props => [];
}

class ShowNotificationSideEffect extends AppSideEffect {
  final NotificationType type;

  const ShowNotificationSideEffect(this.type);

  @override
  List<Object?> get props => [type];
}
