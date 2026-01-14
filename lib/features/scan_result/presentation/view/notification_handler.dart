import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/services/app_side_effect.dart';
import 'package:qr_scanner/core/services/app_side_effect_controller.dart';
import 'package:qr_scanner/core/services/notification_service.dart';

class NotificationHandler extends StatefulWidget {
  final Widget child;

  const NotificationHandler({super.key, required this.child});

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  StreamSubscription<AppSideEffect>? _subscription;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _notificationService.initialize(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscription?.cancel();
    final sideEffectController = getIt<AppSideEffectController>();
    
    _subscription = sideEffectController.stream.listen((sideEffect) {
      if (!mounted) return;
      
      if (sideEffect is ShowNotificationSideEffect) {
        _notificationService.show(
          context: context,
          type: sideEffect.type,
        );
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _notificationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
