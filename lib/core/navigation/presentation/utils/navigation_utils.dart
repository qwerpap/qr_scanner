import '../../data/constants/bottom_navigation_constants.dart';

class NavigationUtils {
  NavigationUtils._();

  static int? getCurrentIndex(String currentLocation) {
    // Normalize path: remove trailing slash and ensure leading slash
    final normalizedPath = currentLocation.trim();
    
    for (int i = 0; i < BottomNavigationConstants.navigationItems.length; i++) {
      final route = BottomNavigationConstants.navigationItems[i].route;
      if (route == normalizedPath) {
        return i;
      }
    }
    // Return null if route is not a main navigation tab (e.g., nested screens)
    return null;
  }
}

