import 'package:flutter/material.dart';
import 'package:shopzonee/model/product_model.dart';
 // Adjust the import based on your project structure

class ProductDetailPage extends StatelessWidget {
  final ProductModel product; // Assuming you have a Product model that includes all required fields

  ProductDetailPage({required this.product}); // Constructor to receive product details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productname ?? 'Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Center(
              child: Image.network(
                product.image ?? '',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            // Product Name
            Text(
              product.productname ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Product Price
            Text(
              'Price: ${product.price ?? 'No Price'}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 8),
            // Product Color
            Text(
              'Color: ${product.color ?? 'No Color'}', // Assuming you have a color field
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            // Product Size
            Text(
              'Size: ${product.size ?? 'No Size'}', // Assuming you have a size field
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            // Product Description
            Text(
              'Description: ${product.description ?? 'No Description'}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
