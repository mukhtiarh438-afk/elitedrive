import 'package:flutter/material.dart';

class FleetModel {
  final IconData icon;
  final String title;
  final String price;
  final bool isSelected;

  FleetModel({
    required this.icon,
    required this.title,
    required this.price,
    this.isSelected = false,
  });
}
