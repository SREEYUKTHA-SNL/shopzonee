import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzonee/model/addressmodel.dart';
import 'package:shopzonee/model/cart_model.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/view/addrrssdetails.dart';
import 'package:shopzonee/view_model/adrdeess_viewmodel.dart';
import 'package:shopzonee/view_model/cart_viewmodel.dart';
import 'package:shopzonee/view_model/order_viewmodel.dart';
import 'package:shopzonee/view_model/paymentviewmodel.dart';
// import 'package:upi_india/upi_app.dart';

class CheckOut2 extends StatefulWidget {
  final Address? selectedAddress;
  final List<CartModel> selectedCartItems;

  const CheckOut2({
    super.key,
    this.selectedAddress,
    required this.selectedCartItems,
  });

  @override
  State<CheckOut2> createState() => _CheckOut2State();
}

class _CheckOut2State extends State<CheckOut2> {
  String _selectedPaymentMethod = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = context.read<UserProvider>().loginId;
      if (id != null) {
        context.read<AddressViewModel>().fetchAddress(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs for payment options
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {}, // Favorite action
                icon: Icon(Icons.favorite, color: Colors.red),
              ),
            ],
          ),
          body: Consumer<AddressViewModel>(
            builder: (context, addressViewModel, child) {
              if (addressViewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              List<Address> addresses = addressViewModel.addresses;
              Address? selectedAddress = addressViewModel.selectedAddress;

              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('STEP 2',
                          style: TextStyle(color: kPrimary, fontSize: 11)),
                      Text(
                        'Payment',
                        style: TextStyle(
                          color: kPrimary,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Conditional rendering for address
                      addresses.isNotEmpty
                          ? (selectedAddress != null
                              ? _buildAddressCard(selectedAddress)
                              : _buildAddressCard(addresses[0]))
                          : Center(
                              child: Column(
                                children: [
                                  Text(
                                    'No address found.',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                       final id = context.read<UserProvider>().loginId;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          
                                          builder: (context) => Viewaddress(loginId:int.parse(id!) ,),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimary,
                                    ),
                                    child: Text(
                                      'Add Address',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      Divider(),
                      SizedBox(height: 20),
                      // Display selected cart items
                      if (widget.selectedCartItems.isNotEmpty) ...[
                        Text(
                          'Selected Cart Items',
                          style: TextStyle(
                            color: kPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        ...widget.selectedCartItems.map((cartItem) {
                          return ListTile(
                            leading: Image.network(cartItem.image ??
                                'https://via.placeholder.com/150'),
                            title:
                                Text(cartItem.productname ?? 'Unknown Product'),
                            subtitle: Text(cartItem.price.toString()),
                          );
                        }).toList(),
                      ] else
                        Center(
                          child: Text(
                            'No items selected.',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      Divider(),
                      // Payment options
                      Column(
                        children: [
                          // Google Pay Option
                          RadioListTile(
                            value: 'Google Pay',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              // context.read<Paymentviewmodel>().initiateTransaction(UpiApp.googlePay);
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Image.network(
                                  'https://w7.pngwing.com/pngs/191/51/png-transparent-google-pay-or-tez-hd-logo-thumbnail.png', // Replace with your Google Pay image asset path
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text('Google Pay'),
                              ],
                            ),
                          ),
                          Divider(),

                          // Credit Card Option
                          RadioListTile(
                            value: 'Credit Card',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Image.network(
                                  'https://cdn-icons-png.flaticon.com/512/6963/6963703.png', // Replace with your Credit Card image asset path
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text('Credit Card'),
                              ],
                            ),
                          ),
                          Divider(),

                          // PhonePe Option
                          RadioListTile(
                            value: 'PhonePe',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              // context.read<Paymentviewmodel>().initiateTransaction(UpiApp.phonePe);

                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvE6-6odTOoKvuJjhWykmi7kblH7Ix9tjwjA&s', // Replace with your PhonePe image asset path
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text('PhonePe'),
                              ],
                            ),
                          ),
                          Divider(),

                          // Paytm Option
                          RadioListTile(
                            value: 'Paytm',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              // context.read<Paymentviewmodel>().initiateTransaction(UpiApp.paytm);

                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Image.network(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEZmfpuk4UoAGXYsf5pVZf98mJR1jd3qFnIA&s', // Replace with your Paytm image asset path
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(width: 10),
                                Text('Paytm'),
                              ],
                            ),
                          ),
                          Divider(),

                          // Cash on Delivery Option
                          RadioListTile(
                            value: 'Cash on Delivery',
                            groupValue: _selectedPaymentMethod,
                            onChanged: (value) {
                              
                              setState(() {
                                _selectedPaymentMethod = value!;
                              });
                            },
                            title: Row(
                              children: [
                                Icon(Icons.attach_money,
                                    size: 40, color: Colors.green),
                                SizedBox(width: 10),
                                Text('Cash on Delivery'),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                      SizedBox(height: 50),
                      // Order button
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final cartViewModel = Provider.of<CartViewModel>(
                                context,
                                listen: false);

                            final cartIdList = widget.selectedCartItems.map(
                              (e) {
                                return e.id;
                              },
                            );
                            final placeOrderViewModel =
                                Provider.of<PlaceOrderViewModel>(context,
                                    listen: false);

                            await placeOrderViewModel.placeOrder(
                                cartidList: cartIdList.toList());

                            await cartViewModel.fetchCartItems();

                            if (placeOrderViewModel.successMessage != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        placeOrderViewModel.successMessage!)),
                              );
                            } else if (placeOrderViewModel.errorMessage !=
                                null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        placeOrderViewModel.errorMessage!)),
                              );
                            }
                            Navigator.pushNamed(
                                context, AppRoutes.bottomnavpage);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 5),
                          ),
                          child: Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Address Card Widget
  Widget _buildAddressCard(Address address) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${address.name}\n${address.city}',
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${address.phonenumber}\n${address.pincode}',
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '${address.district}\n${address.state}',
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? loginId = await prefs.getString('loginId');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Viewaddress(
                              loginId: int.tryParse(loginId!)!,
                            )),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: kPrimary,
                ),
                child: Text(
                  'Select address',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
