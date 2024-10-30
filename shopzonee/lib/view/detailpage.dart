import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String productName;

  const DetailPage({Key? key, required this.productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: Center(
        child: Text(
          'Details for $productName',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}