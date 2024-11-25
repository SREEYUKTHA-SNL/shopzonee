import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/view/addrrssdetails.dart';
import 'package:shopzonee/view_model/adrdeess_viewmodel.dart';


class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  String? name, phonenumber, houseNo, street, city, district, state, pincode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('STEP 1',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text(
                    'Shipping',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (value) => name = value,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your name'
                        : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phonenumber = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'House Number',
                    ),
                    onChanged: (value) {
                      houseNo = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your house number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Street',
                    ),
                    onChanged: (value) {
                      street = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your street';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'City',
                    ),
                    onChanged: (value) {
                      city = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your city';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'District',
                    ),
                    onChanged: (value) {
                      district = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your district';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'State',
                    ),
                    onChanged: (value) {
                      state = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your state';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Pincode',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      pincode = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your pincode';
                      } else if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                        return 'Please enter a valid 6-digit pincode';
                      }
                      return null;
                    },
                  ),
                
                  SizedBox(height: 40),
                  Consumer<AddressViewModel>(
                    builder: (context, addressViewModel, child) {
                      return ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimary),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 13),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(double.maxFinite, 48),
                          ),
                        ),
                        onPressed: addressViewModel.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  String? userid = context
                                      .read<UserProvider>()
                                      .loginId;
                                    
                                  await addressViewModel.addAddress(
                                    userid: userid!,
                                    name: name!,
                                    phonenumber: phonenumber!,
                                    houseNo: houseNo!,
                                    street: street!,
                                    city: city!,
                                    district: district!,
                                    state: state!,
                                    pincode: pincode!,
                                  );

                                  if (addressViewModel.errorMessage != null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              addressViewModel.errorMessage!)),
                                    );
                                  } else {
                                     final id = context.read<UserProvider>().loginId;
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => Viewaddress(loginId: int.parse(id!),),));
                                  }
                                }
                              },
                        child: addressViewModel.isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Continue to payment',
                                style: TextStyle(fontSize: 16),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}