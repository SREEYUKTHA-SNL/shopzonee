import 'package:flutter/material.dart';

class TrendingProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String productPrice;

  TrendingProductCard({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Set a fixed width for the card
      height: 100, // Set a fixed height for the card
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              imageUrl,
              height: 100, // Adjust height for the image
              width: 100, // Adjust width for the image
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10), // Space between image and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  productName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  productPrice,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
