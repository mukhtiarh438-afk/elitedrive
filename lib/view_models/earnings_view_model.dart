import 'package:flutter/material.dart';
import '../core/app_strings.dart';
import '../models/transaction_model.dart';

class EarningsViewModel extends ChangeNotifier {
  bool cashPaymentEnabled = false;

  void toggleCash(bool val) {
    cashPaymentEnabled = val;
    notifyListeners();
  }

  final List<TransactionModel> transactions = [
    TransactionModel(
      title: AppStrings.tx1Title,
      date: AppStrings.tx1Date,
      amount: AppStrings.tx1Amount,
      isPositive: false,
      icon: Icons.directions_car,
    ),
    TransactionModel(
      title: AppStrings.tx2Title,
      date: AppStrings.tx2Date,
      amount: AppStrings.tx2Amount,
      isPositive: true,
      icon: Icons.add_circle,
    ),
    TransactionModel(
      title: AppStrings.tx3Title,
      date: AppStrings.tx3Date,
      amount: AppStrings.tx3Amount,
      isPositive: false,
      icon: Icons.directions_car,
    ),
  ];
}
