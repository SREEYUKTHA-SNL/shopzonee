import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/widget/appbar.dart';

class YourCart extends StatelessWidget {
  YourCart({super.key});

  final List<Map<String, dynamic>> cartProducts = [
    {
      'name': 'Rice Crop Hoodie',
      'price': '43.00',
      'size': 'L',
      'color': 'Cream',
      'image':
          'https://images.unsplash.com/photo-1516726817505-f5ed825624d8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'name': 'Gym Crop Top',
      'price': '39.99',
      'size': 'M',
      'color': 'White',
      'image':
          'https://images.unsplash.com/photo-1521577352947-9bb58764b69a?q=80&w=1972&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'name': 'Sports Sweater',
      'price': '47.99',
      'size': 'L',
      'color': 'Black',
      'image':
          'https://images.unsplash.com/photo-1469460340997-2f854421e72f?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade400,
                      offset: Offset(0, 2),
                      blurRadius: 2)
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xff1E3354),
                  size: 16,
                ),
              ),
            ),
          ),
          title: Text('Your Cart'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // Handle delete action
                          },
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            // Handle share action
                          },
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          icon: Icons.share,
                          label: 'Share',
                        ),
                      ],
                    ),
                    child: Container(
                      height: 130.h,
                      margin: EdgeInsets.symmetric(
                          vertical: 12.5.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade100, blurRadius: 10)
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.r),
                              bottomLeft: Radius.circular(20.r),
                            ),
                            child: Image.network(cartProducts[index]['image']),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    cartProducts[index]['name'],
                                    style: TextStyle(
                                      color: kPrimary,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${cartProducts[index]['price']}',
                                    style: TextStyle(
                                      color: kPrimary,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Size: ${cartProducts[index]['size']} | Color: ${cartProducts[index]['color']}',
                                    style: TextStyle(
                                      color: kSecondary,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () => _showBottomSheet(context),
              child: Container(
                height: 50.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, -2),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Icon(Icons.keyboard_arrow_up, color: kDarkgrey, size: 38),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, -2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product price',
                  style: TextStyle(color: kSecondary, fontSize: 14.sp),
                ),
                Text(
                  '\$110',
                  style: TextStyle(color: kPrimary, fontSize: 15.sp),
                ),
              ],
            ),
            Divider(color: kLightgrey, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping',
                    style: TextStyle(color: kSecondary, fontSize: 14.sp)),
                Text('Freeship',
                    style: TextStyle(color: kPrimary, fontSize: 15.sp)),
              ],
            ),
            Divider(color: kLightgrey, height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal',
                    style: TextStyle(color: kPrimary, fontSize: 14.sp)),
                Text('\$110',
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimary),
                minimumSize:
                    MaterialStateProperty.all(Size(double.maxFinite, 48.h)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.check1);
              },
              child: Text('Proceed to checkout',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            ),
          ],
        ),
      );
    },
  );
}
