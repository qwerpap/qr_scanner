import 'package:qr_scanner/core/constants/image_source.dart';

import '../models/navigation_item.dart';
import 'navigation_constants.dart';
import 'navigation_labels.dart';

class BottomNavigationConstants {
  BottomNavigationConstants._();

  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      iconPath: ImageSource.home,
      label: NavigationLabels.home,
      route: NavigationConstants.home,
    ),
    NavigationItem(
      iconPath: ImageSource.scanQr,
      label: NavigationLabels.scanQr,
      route: NavigationConstants.scanQr,
    ),
    NavigationItem(
      iconPath: ImageSource.myQrCodes,
      label: NavigationLabels.myQrCodes,
      route: NavigationConstants.myQrCodes,
    ),
    NavigationItem(
      iconPath: ImageSource.history,
      label: NavigationLabels.history,
      route: NavigationConstants.history,
    ),
  ];
}
