import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/model/cart_model.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/view/checkoutpage2.dart';
import 'package:shopzonee/view_model/cart_viewmodel.dart';
import 'package:shopzonee/widget/appbar.dart';

class YourCart extends StatefulWidget {
  YourCart({super.key});

  @override
  State<YourCart> createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cartProvider = Provider.of<CartViewModel>(context, listen: false);
        final id = context.read<UserProvider>().loginId;
      cartProvider.fetchCartItems(int.parse(id!));
    });
  }

  List<CartModel> selectedProvider = [];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    

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
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final CartModel products = cartProvider.cartItems[index];
                  return Slidable(
                    key: ValueKey(index),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _confirmDelete(context, products.id, cartProvider);
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
                            child: Image.network(
                              products.image ??
                                  'https://via.placeholder.com/150',
                              fit: BoxFit.cover,
                              width: 130.w,
                              height: 130.h,
                            ),
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
                                    products.productname ?? 'Unknown Product',
                                    style: TextStyle(
                                      color: kPrimary,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    products.price != null
                                        ? '\$${products.price}'
                                        : 'Price not available',
                                    style: TextStyle(
                                      color: kPrimary,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle_outline,
                                            color: Colors.black),
                                        onPressed: () {
                                          // if (product.quantity > 1) {
                                          //   cartProvider.decrementQuantity(product);
                                          // }
                                        },
                                      ),
                                      Text(
                                        '${products.quantity}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle_outline,
                                            color: Colors.black),
                                        onPressed: () {
                                          // cartProvider.incrementQuantity(product);
                                        },
                                      ),
                                      Checkbox(
                                        value: cartProvider
                                                    .selectedItems.length >
                                                index
                                            ? cartProvider.selectedItems[index]
                                            : false,
                                        onChanged: (bool? value) {
                                          if (index <
                                              cartProvider
                                                  .selectedItems.length) {
                                            cartProvider.selectedItems[index] =
                                                value ?? false;

                                            products.isSelected = cartProvider.selectedItems[index];

                                            if(products.isSelected == true){
                                              selectedProvider.add(products);
                                            }else{
                                               selectedProvider.remove(products);

                                            }
                                            cartProvider.calculateTotalPrice();
                                                 // Recalculate total price when selection changes


                                            
                                          }
                                        },
                                      )
                                    ],
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
              onTap: () => _showBottomSheet(context,selectedProvider),
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

void _showBottomSheet(BuildContext context,List<CartModel> selectedCart) {
  final cartProvider = Provider.of<CartViewModel>(context, listen: false);

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
                Text(
                  '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: kPrimary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
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
                // Navigate directly to the Checkout 2 page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckOut2(selectedCartItems: selectedCart),
                    ));
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

void _confirmDelete(
    BuildContext context, int? cartItemId, CartViewModel cartProvider) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text('Delete Item'),
      content:
          Text('Are you sure you want to delete this item from your cart?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(ctx).pop();
            if (cartItemId != null) {
              await cartProvider.deleteCartItem(
                  cartItemId: cartItemId.toString());
            }
          },
          child: Text('Delete'),
        ),
      ],
    ),
  );
}
