import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _loginId;


  String? get loginId => _loginId;

 
  Future<void> loadLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loginId = prefs.getString('loginId');
    notifyListeners();
  }


  Future<void> saveLoginId(String loginId) async {
    try {
      print('kkk');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('loginId', loginId);
      _loginId = loginId;
      notifyListeners();
    } catch (e) {
      print('Failed to save loginId: $e');
    }
  }

  // Remove login ID from shared preferences
  Future<void> removeLoginId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('loginId');
    _loginId = null; // Clear the local loginId variable
    notifyListeners(); // Notify listeners when the login ID is removed
  }
}
