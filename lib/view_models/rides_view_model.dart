import 'package:flutter/material.dart';
import '../core/app_strings.dart';
import '../models/ride_request_model.dart';
import '../models/shift_day_model.dart';

class RidesViewModel extends ChangeNotifier {
  bool isOnline = true;

  void toggleStatus(bool online) {
    isOnline = online;
    notifyListeners();
  }

  final List<ShiftDayModel> shiftDays = [
    ShiftDayModel(day: 'MON', date: 12),
    ShiftDayModel(day: 'TUE', date: 13),
    ShiftDayModel(day: 'WED', date: 14),
    ShiftDayModel(day: 'THU', date: 15, isSelected: true),
    ShiftDayModel(day: 'FRI', date: 16),
  ];

  final List<RideRequestModel> requests = [
    RideRequestModel(
      passengerName: AppStrings.passenger1,
      rating: AppStrings.passenger1Rating,
      milesAway: AppStrings.milesAway,
      price: AppStrings.passenger1Price,
      estTime: AppStrings.estTime,
      pickupAddress: AppStrings.pickupAddr,
      dropoffAddress: AppStrings.dropoffAddr,
      imageUrl: 'https://i.pravatar.cc/150?img=47',
      isMini: false,
    ),
    RideRequestModel(
      passengerName: AppStrings.passenger2,
      rating: '',
      milesAway: AppStrings.passenger2Miles,
      price: AppStrings.passenger2Price,
      pickupAddress: '',
      dropoffAddress: '',
      imageUrl: '',
      isMini: true,
    ),
  ];
}
