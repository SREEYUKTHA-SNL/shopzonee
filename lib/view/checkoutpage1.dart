import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/utils/colors.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16,right: 10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('STEP 1',style:TextStyle(fontWeight:FontWeight.bold,color: Colors.grey) ),
                  Text('Shipping',style: TextStyle(fontSize: 30,fontWeight:FontWeight.bold ),),
                  SizedBox(height: 30,),
              
              
              
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone number',
                    ),
                    keyboardType: TextInputType.phone,
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
                  ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(kPrimary),
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    elevation: WidgetStateProperty.all(0),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(vertical: 13),
                    ),
                    minimumSize: WidgetStateProperty.all(
                      Size(double.maxFinite, 48),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                                                     Navigator.pushNamed(context, AppRoutes.check2);

                    // If the form is valid, display a snackbar or process the data
                   
                  }
                  },
                  child: Text(
                    'Continue to payment',
                    style: TextStyle(fontSize: 16),
                  ),
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
