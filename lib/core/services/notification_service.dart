import 'package:flutter/material.dart';
import 'package:qr_scanner/core/shared/widgets/custom_notification.dart';
import 'notification_type.dart';

class NotificationService {
  NotificationService();

  OverlayEntry? _currentOverlay;
  OverlayState? _overlayState;
  bool _isDismissing = false;

  void initialize(BuildContext context) {
    _overlayState = Overlay.of(context);
  }

  void show({
    required BuildContext context,
    required NotificationType type,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_overlayState == null) {
      _overlayState = Overlay.of(context);
    }

    _dismissCurrentSync();

    final overlayEntry = OverlayEntry(
      builder: (context) {
        final topPadding = MediaQuery.of(context).padding.top + 16;
        return Stack(
          children: [
            Positioned(
              top: topPadding,
              left: 24,
              right: 24,
              child: CustomNotification(
                message: type.message,
                icon: type.icon,
                duration: duration,
                onDismiss: () {
                  _dismissCurrentSync();
                },
              ),
            ),
          ],
        );
      },
    );

    _currentOverlay = overlayEntry;
    _overlayState?.insert(overlayEntry);
  }

  void _dismissCurrentSync() {
    if (_isDismissing) return;
    
    final overlay = _currentOverlay;
    if (overlay != null) {
      _isDismissing = true;
      try {
        overlay.remove();
      } catch (e) {
      } finally {
        _currentOverlay = null;
        _isDismissing = false;
      }
    }
  }

  void dismiss() {
    _dismissCurrentSync();
  }

  void dispose() {
    _dismissCurrentSync();
    _overlayState = null;
  }
}
