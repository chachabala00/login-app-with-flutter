import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/database_helper.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  UserModel? _user;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  bool get isLoading => _isLoading;
  String get error => _error;
  UserModel? get user => _user;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await ApiService.login(username, password);

      if (response['Status_Code'] == 200 &&
          response['Response_Body'] != null &&
          response['Response_Body'].isNotEmpty) {
        _user = UserModel.fromJson(response['Response_Body'][0]);
        await _databaseHelper.insertUser(_user!.toJson());
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response['Message'] ?? 'Login failed';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'An error occurred. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
