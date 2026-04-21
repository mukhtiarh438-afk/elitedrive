import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_themes.dart';
import 'view_models/home_view_model.dart';
import 'view_models/rides_view_model.dart';
import 'view_models/auth_view_model.dart';
import 'view_models/earnings_view_model.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const EliteDriveApp());
}

class EliteDriveApp extends StatelessWidget {
  const EliteDriveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => RidesViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => EarningsViewModel()),
      ],
      child: MaterialApp(
        title: 'Elite Drive',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}