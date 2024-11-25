import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/api_service.dart';
import 'package:shopzonee/services/firebase_auth_services.dart';

class Signupviewmodel extends ChangeNotifier {
  final _firebaseauthservice = Firebaseauthservices();

  bool loading = false;
    String _name = '';
  String _email = '';

  String get name => _name;
  String get email => _email;

  // Method to set loading state
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> Signupwithgoogle(BuildContext context) async {
    setLoading(true); // Start loading
    try {
      await _firebaseauthservice.Signinwithgoogle();
      Navigator.pushNamed(context, AppRoutes.bottomnavpage);
    } on FirebaseAuthException catch (e) {
     ;
    } catch (e) {
      e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> register(
      {required String name,
      required String number,
      required String email,
      required String password,
      required BuildContext context}) async {
    setLoading(true);
    try {
       _name = name;
      _email = email;
      await ApiService().registerUser(
        name: name,
        email: email,
        number: number,
        password: password,
       
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Register success'),
        ));
      Navigator.pushNamed(context, AppRoutes.signinPage);

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
