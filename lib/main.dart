import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/app_colors.dart';
import 'core/app_strings.dart';
import 'core/app_text_size.dart';
import 'core/app_themes.dart';
import 'view_models/home_view_model.dart';
import 'view_models/rides_view_model.dart';
import 'views/homeScreen/home_screen.dart';
import 'views/driverDashboardScreen/driver_dashboard_screen.dart';
import 'views/fleetOwnerScreen/fleet_owner_screen.dart';
import 'views/supportScreen/support_screen.dart';

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
      ],
      child: MaterialApp(
        title: 'Editorial Mobility',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const MainShell(),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    DriverDashboardScreen(),
    FleetOwnerScreen(),
    SupportScreen(),
    Scaffold(body: Center(child: Text('Profile'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: _screens[_index],
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        backgroundColor: AppColors.whiteColor,
        selectedItemColor: AppColors.homePrimary,
        unselectedItemColor: AppColors.homeHintText,
        selectedLabelStyle: TextStyle(
          fontSize: AppTextSize.labelSmall(context),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: AppTextSize.labelSmall(context),
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: AppStrings.navHome),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car_outlined),
              activeIcon: Icon(Icons.directions_car),
              label: AppStrings.navRides),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: AppStrings.navEarnings),
          BottomNavigationBarItem(
              icon: Icon(Icons.help_outline),
              activeIcon: Icon(Icons.help),
              label: AppStrings.navSupport),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: AppStrings.navProfile),
        ],
      ),
    );
  }
}
