import 'package:flutter/material.dart';
import 'package:shopzonee/routes/routes.dart';

import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/widget/appbar.dart';

class CheckOut2 extends StatelessWidget {
  const CheckOut2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: () {
              
            }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
            actions: [
              IconButton(onPressed: () {
                
              }, icon: Icon(Icons.favorite,color: Colors.red,))
            ],

          ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STEP 2',
                style: TextStyle(color: kPrimary, fontSize: 11),
              ),
              Text(
                'Payment',
                style: TextStyle(
                    color: kPrimary, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 64,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 20,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: kSecondary,
                        ),
                        Text(
                          'Cash',
                          style: TextStyle(color: kSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 64,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kSecondary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 20,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: Colors.white,
                        ),
                        Text(
                          'Credit Card',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      width: 100,
                      height: 64,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 20,
                              offset: Offset(0, 4))
                        ],
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        color: kSecondary,
                        size: 40,
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choose your card',
                    style: TextStyle(
                        color: kPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Add new+',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Container(
                width: double.maxFinite,
                height: 200,
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 20,
                        offset: Offset(0, 4))
                  ],
                ),
              ),
              Text(
                'or check out with',
                style: TextStyle(
                    color: kPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 45,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: kLightgrey)),
                  ),
                  Container(
                    width: 70,
                    height: 45,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: kLightgrey)),
                  ),
                  Container(
                    width: 70,
                    height: 45,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: kLightgrey)),
                  ),
                  Container(
                    width: 70,
                    height: 45,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: kLightgrey)),
                  ),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () => _showBottomSheet(context),
                child: Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            offset: Offset(0, -2),
                            blurRadius: 5)
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150, vertical: 20),
                      child: Divider(
                        color: kLightgrey,
                        thickness: 3,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Container(
        padding: EdgeInsets.fromLTRB(32, 32, 32, 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
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
                  style: TextStyle(
                    color: kSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '\$110',
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: kLightgrey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: TextStyle(
                    color: kSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Freeship',
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(color: kLightgrey),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal',
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  '\$110',
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                  checkColor: Colors.white,
                  activeColor: kGreen,
                  side: BorderSide(color: kLightgrey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                Text(
                  'I agree to Terms and Conditions',
                  style: TextStyle(
                    color: kPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            SizedBox(height: 28),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimary),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 13),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(double.maxFinite, 48),
                ),
              ),
              onPressed: () {
                                                     Navigator.pushNamed(context, AppRoutes.check3);

              },
              child: Text(
                'Place my order',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    },
  );
}