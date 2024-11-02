import 'package:flutter/material.dart';
import 'package:shopzonee/utils/colors.dart';

class Checkout3 extends StatelessWidget {
  const Checkout3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Completed',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(
              height: 80,
            ),
            Center(
                child: Image.asset(
              'assets/images/order (1) 2.png',
            )),
            SizedBox(
              height: 70,
            ),
            Center(
                child: Container(
                    width: 400,
                    child: Text(
                      "Thank you for your purchase.\nYou can view your order in 'My Orders'\nsection.",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ))),
                    SizedBox(
              height: 150,
            ),

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
                {
                 
                }
              },
              child: Text(
                'Continue shopping',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
