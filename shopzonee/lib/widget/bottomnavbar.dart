import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzonee/model/product_model.dart';
import 'package:shopzonee/view_model/cart_viewmodel.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int productID;
  const CustomBottomNavBar({super.key, required this.productID,});

  @override
  Widget build(BuildContext context) {
    print(productID);
    return Container(
      height: 77.h,
      decoration: BoxDecoration(
          color: Color(0xff343434),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 24,
            color: Colors.white,
          ),
          SizedBox(
            width: 13.w,
          ),
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? userId = prefs.getString('userId');
              print("User ID: ${userId}");

              if (userId != null) {

                print("Product id: ${productID}");

                Provider.of<CartViewModel>(context, listen: false).addToCart(
                  productid: productID.toString(),
                  userId: userId,
                );

                

                // Show a snackbar message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("added to cart!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                // Handle the case when loginId is null (user is not logged in)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please log in to add items to the cart."),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Text(
              'Add To Cart',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
