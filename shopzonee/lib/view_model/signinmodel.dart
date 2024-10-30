import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/main.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/api_service.dart';
import 'package:shopzonee/services/firebase_auth_services.dart';
import 'package:shopzonee/services/shared_pref.dart';

class Signinviewmodel extends ChangeNotifier {
  final _firebaseauthservice = Firebaseauthservices();

  bool loading = false;

  // Method to set loading state
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> Signinwithgoogle(BuildContext context) async {
    setLoading(true); // Start loading
    try {
      await _firebaseauthservice.Signinwithgoogle();
      Navigator.pushNamed(context, AppRoutes.bottomnavpage);
    } on FirebaseAuthException catch (e) {
     print( e.message);
    } catch (e) {
      e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> login(
      {
      required String email,
      required String password,
      required BuildContext context}) async {
    setLoading(true);
    try {
      final user =  await ApiService().loginUser(
     
        email: email,
     
        password: password,
       
      );
      
      await context.read<UserProvider>().saveUserId(user.userId.toString());

      Navigator.pushNamed(context, AppRoutes.bottomnavpage);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
        
      );

    } finally {
      setLoading(false); // Stop loading
    }
  }
}
