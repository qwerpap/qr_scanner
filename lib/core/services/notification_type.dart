import 'package:flutter/material.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';

enum NotificationType {
  copied,
  saved,
  shared,
  noQrFound,
  urlOpenError,
  simulatorNotSupported;

  String message(BuildContext context) {
    switch (this) {
      case NotificationType.copied:
        return context.l10n.copiedToClipboard;
      case NotificationType.saved:
        return context.l10n.savedSuccessfully;
      case NotificationType.shared:
        return context.l10n.sharedSuccessfully;
      case NotificationType.noQrFound:
        return context.l10n.noQrFoundInImage;
      case NotificationType.urlOpenError:
        return context.l10n.cannotOpenUrl;
      case NotificationType.simulatorNotSupported:
        return context.l10n.simulatorNotSupported;
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
      case NotificationType.simulatorNotSupported:
        return Icons.phone_iphone;
    }
  }
}
