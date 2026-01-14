import 'package:flutter/material.dart';

class NavigationIcons {
  NavigationIcons._();

  static const IconData home = Icons.home;
  static const IconData scanQr = Icons.qr_code_scanner;
  static const IconData myQrCodes = Icons.folder;
  static const IconData history = Icons.history;
  
  static IconData getIconByRoute(String route) {
    switch (route) {
      case '/home':
        return home;
      case '/scan-qr':
        return scanQr;
      case '/my-qr-codes':
        return myQrCodes;
      case '/history':
        return history;
      default:
        return home;
    }
  }
}

