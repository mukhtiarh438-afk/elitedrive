import 'package:flutter/material.dart';
import '../core/app_strings.dart';
import '../models/driver_bid_model.dart';

class BidsViewModel extends ChangeNotifier {
  int selectedTab = 0; // 0 = Driver Bids, 1 = Fixed Pricing

  void selectTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  final List<DriverBidModel> bids = [
    DriverBidModel(
      name: AppStrings.driver1Name,
      car: AppStrings.driver1Car,
      rating: AppStrings.driver1Rating,
      bid: AppStrings.driver1Bid,
      imageUrl: 'https://i.pravatar.cc/150?img=11',
      isFavorite: true,
    ),
    DriverBidModel(
      name: AppStrings.driver2Name,
      car: AppStrings.driver2Car,
      rating: AppStrings.driver2Rating,
      bid: AppStrings.driver2Bid,
      imageUrl: 'https://i.pravatar.cc/150?img=5',
    ),
    DriverBidModel(
      name: AppStrings.driver3Name,
      car: AppStrings.driver3Car,
      rating: AppStrings.driver3Rating,
      bid: AppStrings.driver3Bid,
      imageUrl: 'https://i.pravatar.cc/150?img=3',
    ),
  ];
}
