import 'package:flutter/material.dart';
import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';

import '../models/navigation_item.dart';
import 'navigation_constants.dart';

class BottomNavigationConstants {
  BottomNavigationConstants._();

  static List<NavigationItem> getNavigationItems(BuildContext context) {
    return [
      NavigationItem(
        iconPath: ImageSource.home,
        label: context.l10n.home,
        route: NavigationConstants.home,
      ),
      NavigationItem(
        iconPath: ImageSource.scanQr,
        label: context.l10n.scan,
        route: NavigationConstants.scanQr,
      ),
      NavigationItem(
        iconPath: ImageSource.myQrCodes,
        label: context.l10n.myQrCodesTitle,
        route: NavigationConstants.myQrCodes,
      ),
      NavigationItem(
        iconPath: ImageSource.history,
        label: context.l10n.historyTitle,
        route: NavigationConstants.history,
      ),
    ];
  }
}
