import 'package:flutter/material.dart';
import '../views/homeScreen/home_screen.dart';

class AppRoutes {
  static const String homeScreen = '/';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
