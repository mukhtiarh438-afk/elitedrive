import 'package:flutter/material.dart';

class SuggestedPlaceModel {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String address;

  SuggestedPlaceModel({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.address,
  });
}
