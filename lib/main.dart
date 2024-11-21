import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view/allproductspage.dart';
import 'package:shopzonee/view/checkoutpage2.dart';
import 'package:shopzonee/view/checkoutpage3.dart';
import 'package:shopzonee/view/discoverpage.dart';
import 'package:shopzonee/view/homepage.dart';
import 'package:shopzonee/view/product_full.dart';
import 'package:shopzonee/view/profilepage.dart';
import 'package:shopzonee/view/your_cart.dart';
import 'package:shopzonee/view_model/adrdeess_viewmodel.dart';
import 'package:shopzonee/view_model/cart_viewmodel.dart';
import 'package:shopzonee/view_model/category_viewmodel.dart';
import 'package:shopzonee/view_model/fav_viewmodel.dart'; // Import the FavoritesProvider
import 'package:firebase_core/firebase_core.dart'; // Import Firebase core
import 'package:shopzonee/view_model/fetchproduct_viewmodel.dart';
import 'package:shopzonee/view_model/order_viewmodel.dart';
import 'package:shopzonee/view_model/paymentviewmodel.dart';
import 'package:shopzonee/view_model/signinmodel.dart';
import 'package:shopzonee/view_model/signup_viewmodel.dart';
import 'firebase_options.dart'; // Make sure this is the correct path to your Firebase options

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final user =UserProvider();

 await user.loadLoginId();
 



 

  // Initialize Firebase

  runApp(MyApp(
    loginId: user.loginId,
  
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.loginId});

  String? loginId;


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => Signupviewmodel()),
        ChangeNotifierProvider(create: (_) => Signinviewmodel()),
        ChangeNotifierProvider(create: (_) => PlaceOrderViewModel()),
        // ChangeNotifierProvider(create: (_) => Paymentviewmodel()),


        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CategoryViewmodel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
        ChangeNotifierProvider(create: (_) => AddressViewModel()),

       


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
            initialRoute: widget.loginId!=null?AppRoutes.bottomnavpage :  AppRoutes.welcomePage,
          
         
            
            onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
            debugShowCheckedModeBanner: false,
            // Optionally, you can specify the home route like this:
           // home: CheckOut2(),
          );
        },
      ),
    );
  }
}
