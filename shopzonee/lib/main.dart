import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view/allproductspage.dart';
import 'package:shopzonee/view/checkoutpage3.dart';
import 'package:shopzonee/view/discoverpage.dart';
import 'package:shopzonee/view/homepage.dart';
import 'package:shopzonee/view/product_full.dart';
import 'package:shopzonee/view/profilepage.dart';
import 'package:shopzonee/view/your_cart.dart';
import 'package:shopzonee/view_model/category_viewmodel.dart';
import 'package:shopzonee/view_model/fav_provider.dart'; // Import the FavoritesProvider
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:shopzonee/view_model/fetchproduct_mode.dart';
import 'package:shopzonee/view_model/signup_provider.dart';
import 'firebase_options.dart'; // Make sure this is the correct path to your Firebase options

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userId = await UserProvider().loadUserId();

  // Initialize Firebase

  runApp(MyApp(
    userId: userId,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.userId});

  String? userId;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => Signupviewmodel()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CategoryViewmodel()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            title: 'Shopzonee',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: userId != null
                ? AppRoutes.bottomnavpage
                : AppRoutes.welcomePage,
            onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
            debugShowCheckedModeBanner: false,
            // Optionally, you can specify the home route like this:
            // home: Allproductspage(),
          );
        },
      ),
    );
  }
}
