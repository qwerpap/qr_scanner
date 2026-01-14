import 'package:flutter/material.dart';

enum NotificationType {
  copied,
  saved,
  shared,
  noQrFound,
  urlOpenError;

  String get message {
    switch (this) {
      case NotificationType.copied:
        return 'Copied to clipboard';
      case NotificationType.saved:
        return 'Saved successfully';
      case NotificationType.shared:
        return 'Shared successfully';
      case NotificationType.noQrFound:
        return 'No QR code found in image';
      case NotificationType.urlOpenError:
        return 'Cannot open URL';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.copied:
        return Icons.copy;
      case NotificationType.saved:
        return Icons.bookmark;
      case NotificationType.shared:
        return Icons.share;
      case NotificationType.noQrFound:
        return Icons.error_outline;
      case NotificationType.urlOpenError:
        return Icons.error_outline;
    }
  }
}
