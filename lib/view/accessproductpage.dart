import 'package:flutter/material.dart';

class AccessoriesproductPage extends StatelessWidget {
  final String title;

  const AccessoriesproductPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample products data
    final List<Map<String, String>> products = [
      {
        'imageUrl': 'assets/images/Frame 33149.png',
        'name': 'Product 1',
      },
      {
        'imageUrl': 'assets/images/Frame 33123.png',
        'name': 'Product 2',
      },
      {
        'imageUrl': 'assets/images/Frame 33149.png',
        'name': 'Product 3',
      },
      {
        'imageUrl': 'assets/images/Frame 33123.png',
        'name': 'Product 4',
      },
      // Add more products as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 products per row
            childAspectRatio: 0.75, // Adjust this ratio for the card shape
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ProductCard(
              imageUrl: products[index]['imageUrl']!,
              productName: products[index]['name']!,
            );
          },
        ),
      ),
    );
  }
}

// Example ProductCard widget
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white, // Background color for the card
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity, // Full width of the container
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
