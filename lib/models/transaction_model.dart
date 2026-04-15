import 'package:flutter/material.dart';

class TransactionModel {
  final String title;
  final String date;
  final String amount;
  final bool isPositive;
  final IconData icon;

  TransactionModel({
    required this.title,
    required this.date,
    required this.amount,
    required this.isPositive,
    required this.icon,
  });
}
