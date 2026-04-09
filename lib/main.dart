import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_themes.dart';
import 'view_models/home_view_model.dart';
import 'views/homeScreen/home_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'Editorial Mobility',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
