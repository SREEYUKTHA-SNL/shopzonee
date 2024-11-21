import 'package:flutter/material.dart';
import 'package:shopzonee/view/allproductspage.dart';
import 'package:shopzonee/view/bottomnavpage.dart';
import 'package:shopzonee/view/checkoutpage1.dart';
import 'package:shopzonee/view/checkoutpage2.dart';
import 'package:shopzonee/view/checkoutpage3.dart';
import 'package:shopzonee/view/forgotpasspage.dart';
import 'package:shopzonee/view/homepage.dart';
import 'package:shopzonee/view/newpasspage.dart';
import 'package:shopzonee/view/signinpage.dart';
import 'package:shopzonee/view/signuppage.dart';

import 'package:shopzonee/view/intro1page.dart';
import 'package:shopzonee/view/verificationpage.dart';
import 'package:shopzonee/view/welcomepage.dart';

class AppRoutes {
  static const String welcomePage = '/';
  static const String signupPage = '/signup';
  static const String signinPage = '/signin';
  static const String intro1Page = '/intro1';
  static const String homepage = '/homepage';
  static const String newpassword = '/newpassword';

  static const String allproductpage = '/allproductpage';
  static const String bottomnavpage = '/bottomnavpage';
  static const String forgotpassword = '/forgotpassword';
  static const String verification = '/verification';
   static const String check1 = '/check1';
  static const String check2 = '/check2';
  static const String check3 = '/check3';






  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcomePage:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case signupPage:
        return MaterialPageRoute(builder: (_) => SignupPage());
      case signinPage:
        return MaterialPageRoute(builder: (_) => SigninPage());
      case intro1Page:
        return MaterialPageRoute(builder: (_) => Intro1page());
      case homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case forgotpassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case allproductpage:
        return MaterialPageRoute(builder: (_) => Allproductspage());
      case newpassword:
        return MaterialPageRoute(builder: (_) => CreateNewPasswordPage());
      case bottomnavpage:
        return MaterialPageRoute(builder: (_) => BottomNavigationPage());
      case verification:
        return MaterialPageRoute(builder: (_) => VerificationPage());
      case check1:
        return MaterialPageRoute(builder: (_) => OrderPage());
    
      
      case check3:
        return MaterialPageRoute(builder: (_) => Checkout3());
     
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
