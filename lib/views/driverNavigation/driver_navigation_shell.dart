import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_size.dart';
import '../driverDashboardScreen/driver_dashboard_screen.dart';
import '../bidScreen/bid_screen.dart';
import '../earningRiderScreen/earning_rider_screen.dart';
import '../fleetOwnerScreen/fleet_owner_screen.dart';
import '../supportScreen/support_screen.dart';

class DriverNavigationShell extends StatefulWidget {
  const DriverNavigationShell({super.key});

  @override
  State<DriverNavigationShell> createState() => _DriverNavigationShellState();
}

class _DriverNavigationShellState extends State<DriverNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DriverDashboardScreen(),
    BidScreen(),
    EarningsScreen(),
    FleetOwnerScreen(),
    SupportScreen(),
    Scaffold(body: Center(child: Text('Profile'))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBackground,
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel_outlined),
            activeIcon: Icon(Icons.gavel),
            label: 'Bids',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            activeIcon: Icon(Icons.account_balance_wallet),
            label: 'Earnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined),
            activeIcon: Icon(Icons.directions_car),
            label: 'Fleet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            activeIcon: Icon(Icons.help),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
