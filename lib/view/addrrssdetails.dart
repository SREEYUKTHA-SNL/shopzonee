import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/model/addressmodel.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view/checkoutpage1.dart';
import 'package:shopzonee/view/editpage.dart';
import 'package:shopzonee/view_model/adrdeess_viewmodel.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/widget/appbar.dart';

class Viewaddress extends StatefulWidget {
  final int loginId;
  const Viewaddress({super.key, required this.loginId});

  @override
  State<Viewaddress> createState() => _ViewaddressState();
}

class _ViewaddressState extends State<Viewaddress> {
  int? selectedIndex; 

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = context.read<UserProvider>().loginId;
      context.read<AddressViewModel>().fetchAddress(id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite, color: Colors.red),
              ),
            ],
          ),
          body: Consumer<AddressViewModel>(
            builder: (context, addressViewModel, child) {
              if (addressViewModel.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (addressViewModel.errorMessage != null) {
                return Center(child: Text(addressViewModel.errorMessage!));
              }

              List<Address> addresses = addressViewModel.addresses;

              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      if (addresses.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                color: kPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            ...addresses.map((address) {
                              int index = addresses.indexOf(address); 
                              bool isSelected = selectedIndex == index; 
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                elevation: 5, // Optional: Adds shadow effect
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white, // Change color when selected
                                child: ListTile(
                                  title: Text(
                                    "${address.name}, ${address.houseNo}, ${address.street}, ${address.city}, ${address.state}, ${address.pincode}",
                                    style: TextStyle(color: kPrimary),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    "Phone: ${address.phonenumber}",
                                    style: TextStyle(color: kPrimary),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index; // Update selected address
                                    });
                                    context.read<AddressViewModel>().selectAddress(address);
                                    Navigator.pop(context); // Close the page and go back to CheckOut2
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScreen(address:address,loginId:widget.loginId),));
                                        },
                                        icon: Icon(Icons.edit, color: kPrimary),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                         
                                          context.read<AddressViewModel>().deleteAddress(address.id!,context);
                                        },
                                        icon: Icon(Icons.delete, color: kPrimary),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 150), // Adjust padding as necessary
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to Add Address page
                Navigator.pushNamed(context, AppRoutes.check1);
              },
              child: Icon(Icons.add, color: Colors.white),
              backgroundColor: kPrimary, // You can customize the color
            ),
          ),
        ),
      ),
    );
  }
}
