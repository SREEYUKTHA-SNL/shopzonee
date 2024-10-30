import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String? _userId;

  // Getter for userId
  String? get userId => _userId;

  // Load user ID from shared preferences
  Future<String?> loadUserId() async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
  
    _userId = prefs.getString('userId');
    
  
    notifyListeners(); 
    return _userId;// Notify listeners when the user ID is loaded
  }

  // Save user ID to shared preferences
  Future<void> saveUserId(String userId) async {
   try{
     SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    _userId = userId; // Update the local userId variable
 
    notifyListeners();

   }catch(e){


   } // Notify listeners when the user ID is updated
  }

  // Remove user ID from shared preferences
  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    _userId = null; // Clear the local userId variable
    notifyListeners(); // Notify listeners when the user ID is removed
  }
}
