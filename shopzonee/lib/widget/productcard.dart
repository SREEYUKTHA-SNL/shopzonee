import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productPrice;
  final double width;
  final double height;

  ProductCard({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    this.width = 180,
    this.height = 230,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, // Use the specified width
      height: height, // Use the specified height
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            productName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 4),
          Text(
            productPrice,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
