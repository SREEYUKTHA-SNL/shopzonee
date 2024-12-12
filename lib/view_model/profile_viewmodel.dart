import 'package:flutter/material.dart';
import 'package:shopzonee/model/profile_model.dart';
import 'package:shopzonee/services/profile_service.dart';



class ProfileViewModel extends ChangeNotifier {
  final Profileservice _apiService = Profileservice();
  Profile? _user;
  
  bool _isLoading = false;
  String? _errorMessage;

  Profile? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchUserDetails(int userId) async {
    print('llllllllllllllllllllllllllllllllllllllllllllll');
    print(_user);
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _user = await _apiService.fetchUserDetails(userId);
    } catch (e) {
      _errorMessage = 'Failed to fetch user details';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}