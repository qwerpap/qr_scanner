import '../../data/constants/navigation_constants.dart';

class NavigationUtils {
  NavigationUtils._();

  static int? getCurrentIndex(String currentLocation) {
    // Normalize path: remove trailing slash and ensure leading slash
    final normalizedPath = currentLocation.trim();
    
    // Define routes in order (matching the navigation items order)
    final routes = [
      NavigationConstants.home,
      NavigationConstants.scanQr,
      NavigationConstants.myQrCodes,
      NavigationConstants.history,
    ];
    
    for (int i = 0; i < routes.length; i++) {
      if (routes[i] == normalizedPath) {
        return i;
      }
    }
    // Return null if route is not a main navigation tab (e.g., nested screens)
    return null;
  }
}

