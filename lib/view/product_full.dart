import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopzonee/model/product_model.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/widget/appbar.dart';
import 'package:shopzonee/widget/bottomnavbar.dart';
import 'package:shopzonee/widget/starchart.dart';
import 'package:shopzonee/widget/starrating.dart';


class ProductFull extends StatefulWidget {
   final ProductModel product;
  ProductFull({super.key, required this.product});
 

  @override
  _ProductFullState createState() => _ProductFullState();
}

class _ProductFullState extends State<ProductFull> {
  
   
  final List images = [
    "https://images.unsplash.com/photo-1516726817505-f5ed825624d8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1521577352947-9bb58764b69a?q=80&w=1972&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1469460340997-2f854421e72f?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
  ];

 



  @override
  

  @override
  Widget build(BuildContext context) {
    print('Prod ID: ${widget.product.id}');
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar:AppBar(
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
            ),),),),
            actions: [
              Container(
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
                child: IconButton(onPressed: () {
                  
                }, icon: Icon(Icons.favorite,color: Colors.red,)),
              )
            ],

            
            title: Text('Your Cart'),
            centerTitle: true,

          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Center(
              child: Image.network(
                widget.product.image ?? '',
                height: 550,
                width: 350,
                fit: BoxFit.cover,
              ),
            ),

                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(32, 37, 32, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.r),
                        topRight: Radius.circular(25.r)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          offset: Offset(0, -2),
                          blurRadius: 5)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                         widget.product.productname!,
                            style: TextStyle(
                                color: kPrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                             widget.product.price!,
                            style: TextStyle(
                                color: kPrimary,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      StarRating(
                        rating: 5,
                        noOfRatings: 83,
                      ),
                      Padding(
                        //*Divider

                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          color: Color(0xffF3F3F6),
                        ),
                      ),
                      Row(
                        //*Color and Size
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            //Color
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 widget.product.color!,
                                style: TextStyle(
                                    color: kSecondary, fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 150.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffE7C0A7)),
                                    ),
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff050302)),
                                    ),
                                    Container(
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffEE6969)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            //Color
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                 widget.product.size!,
                                style: TextStyle(
                                    color: kSecondary, fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              SizedBox(
                                width: 150.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFAFAFA)),
                                      child: Text('S'),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFAFAFA)),
                                      child: Text('M'),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: kDarkgrey),
                                      child: Text(
                                        'L',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Padding(
                        //*Divider

                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          color: Color(0xffF3F3F6),
                        ),
                      ),
                      Theme(
                        //*Description
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding:
                              EdgeInsets.only(right: 20, bottom: 15, top: 10),
                          iconColor: kDarkgrey,
                          title: Text(
                            'Description',
                            style: TextStyle(
                                color: kPrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Text(
                              widget.product.description!,
                              style: TextStyle(
                                color: kDarkgrey,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Theme(
                        //*Reviews
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: EdgeInsets.zero,
                          childrenPadding: EdgeInsets.only(bottom: 15, top: 10),
                          iconColor: kDarkgrey,
                          title: Text(
                            'Reviews',
                            style: TextStyle(
                                color: kPrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '4.9',
                                      style: TextStyle(
                                          color: kPrimary,
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'OUT OF 5',
                                      style: TextStyle(
                                        color: kSecondary,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    Spacer(),
                                    StarRating(rating: 5, noOfRatings: 83),
                                  ],
                                ),
                                StarRatingChart(),
                                //*Each Reviews
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(images[0]),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Jennifer Rose',
                                                style: TextStyle(
                                                    color: kPrimary,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              //Stars
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center, // Center the stars
                                                children:
                                                    List.generate(5, (index) {
                                                  return Icon(
                                                    Icons
                                                        .star, // Filled or outlined star
                                                    color:
                                                        kGreen, // Color of the stars
                                                    size:
                                                        16, // Size of the stars
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            '5 min ago',
                                            style: TextStyle(
                                              color: kSecondary,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'I love it.  Awesome customer service!! Helped me out with adding an additional item to my order. Thanks again!',
                                        style: TextStyle(
                                          color: kDarkgrey,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(images[2]),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Kelly Rihanna',
                                                style: TextStyle(
                                                    color: kPrimary,
                                                    fontSize: 13.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              //Stars
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center, // Center the stars
                                                children:
                                                    List.generate(5, (index) {
                                                  return Icon(
                                                    Icons
                                                        .star, // Filled or outlined star
                                                    color:
                                                        kGreen, // Color of the stars
                                                    size:
                                                        16, // Size of the stars
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            '9 min ago',
                                            style: TextStyle(
                                              color: kSecondary,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'I\'m very happy with order, It was delivered on and good quality. Recommended!',
                                        style: TextStyle(
                                          color: kDarkgrey,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
           bottomNavigationBar: CustomBottomNavBar(productID: widget.product.id! ,)),
            
      );
    
  }
}
