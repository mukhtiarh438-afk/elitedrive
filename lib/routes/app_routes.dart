import 'package:flutter/material.dart';
import '../views/userSelectionScreen/user_selection_screen.dart';
import '../views/customerNavigation/customer_navigation_shell.dart';
import '../views/driverNavigation/driver_navigation_shell.dart';
import '../views/authScreen/login_screen.dart';
import '../views/supportScreen/support_screen.dart';

class AppRoutes {
  // User Selection
  static const String userSelection = '/';

  // Customer Routes
  static const String customerHome = '/customer/home';
  static const String customerActiveRide = '/customer/active-ride';
  static const String customerFleet = '/customer/fleet';

  // Driver Routes
  static const String driverDashboard = '/driver/dashboard';
  static const String driverBids = '/driver/bids';
  static const String driverEarnings = '/driver/earnings';
  static const String driverFleet = '/driver/fleet';

  // Shared Routes
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String support = '/support';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case userSelection:
        return MaterialPageRoute(builder: (_) => const UserSelectionScreen());

      // Customer Routes
      case customerHome:
        return MaterialPageRoute(
          builder: (_) => const CustomerNavigationShell(),
        );
      case customerActiveRide:
        return MaterialPageRoute(
          builder: (_) => const CustomerNavigationShell(),
        );
      case customerFleet:
        return MaterialPageRoute(
          builder: (_) => const CustomerNavigationShell(),
        );

      // Driver Routes
      case driverDashboard:
        return MaterialPageRoute(builder: (_) => const DriverNavigationShell());
      case driverBids:
        return MaterialPageRoute(builder: (_) => const DriverNavigationShell());
      case driverEarnings:
        return MaterialPageRoute(builder: (_) => const DriverNavigationShell());
      case driverFleet:
        return MaterialPageRoute(builder: (_) => const DriverNavigationShell());

      // Shared Routes
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case support:
        return MaterialPageRoute(builder: (_) => const SupportScreen());

      default:
        return MaterialPageRoute(builder: (_) => const UserSelectionScreen());
    }
  }
}
