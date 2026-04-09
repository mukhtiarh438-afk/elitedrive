import 'package:flutter/material.dart';
import '../core/app_strings.dart';
import '../core/app_colors.dart';
import '../models/fleet_model.dart';
import '../models/suggested_place_model.dart';
import '../models/driver_model.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedNavIndex = 0;
  int get selectedNavIndex => _selectedNavIndex;

  void onNavTap(int index) {
    _selectedNavIndex = index;
    notifyListeners();
  }

  void selectFleet(int index) {
    for (int i = 0; i < fleetOptions.length; i++) {
      fleetOptions[i] = FleetModel(
        icon: fleetOptions[i].icon,
        title: fleetOptions[i].title,
        price: fleetOptions[i].price,
        isSelected: i == index,
      );
    }
    notifyListeners();
  }

  final List<FleetModel> fleetOptions = <FleetModel>[
    FleetModel(
      icon: Icons.directions_bus,
      title: AppStrings.economy,
      price: AppStrings.economyPrice,
      isSelected: false,
    ),
    FleetModel(
      icon: Icons.directions_car,
      title: AppStrings.comfort,
      price: AppStrings.comfortPrice,
      isSelected: true,
    ),
    FleetModel(
      icon: Icons.directions_car_filled,
      title: AppStrings.luxury,
      price: AppStrings.luxuryPrice,
      isSelected: false,
    ),
  ];

  final List<SuggestedPlaceModel> suggestedPlaces = [
    SuggestedPlaceModel(
      icon: Icons.work,
      iconBg: AppColors.hubIconBg,
      iconColor: AppColors.hubIconColor,
      title: AppStrings.creativeHub,
      address: AppStrings.creativeHubAddr,
    ),
    SuggestedPlaceModel(
      icon: Icons.home,
      iconBg: AppColors.homeIconBg,
      iconColor: AppColors.homeIconColor,
      title: AppStrings.home,
      address: AppStrings.homeAddr,
    ),
  ];

  final List<DriverModel> drivers = [
    DriverModel(name: AppStrings.driverMarcus, rating: '4.9', imageUrl: 'https://i.pravatar.cc/150?img=11'),
    DriverModel(name: AppStrings.driverElena,  rating: '5.0', imageUrl: 'https://i.pravatar.cc/150?img=5'),
    DriverModel(name: AppStrings.driverDavid,  rating: '4.8', imageUrl: 'https://i.pravatar.cc/150?img=3'),
  ];
}
