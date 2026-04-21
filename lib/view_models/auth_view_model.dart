import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
  }

  Future<void> signup(String name, String email, String password) async {
    setLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setLoading(false);
  }
}
