import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopzonee/view_model/order_viewmodel.dart';

class OrderDetailsPage extends StatefulWidget {
  final int userId;

  OrderDetailsPage({required this.userId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PlaceOrderViewModel>(context, listen: false)
          .viewOrder(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.teal),
        elevation: 0,
      ),
      body: Consumer<PlaceOrderViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return Center(
                child: CircularProgressIndicator(color: Colors.teal));
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: TextStyle(color: Colors.teal, fontSize: 18),
              ),
            );
          }

          final orderData = viewModel.orderData;

          if (orderData == null || orderData['data'] == null) {
            return Center(
              child: Text(
                'No order data available',
                style: TextStyle(color: Colors.greenAccent, fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: orderData['data'].length,
            itemBuilder: (context, index) {
              final item = orderData['data'][index];

              return Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['productname'] ?? 'Unknown Item',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Divider(color: Colors.black.withOpacity(0.5)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Item ID: ${item['productid'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'User ID: ${item['userid'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.format_list_numbered,
                              color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Quantity: ${item['quantity'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.black),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Price: ${item['price'] ?? 'N/A'}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Date: ${item['date'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 12),
                      item['image'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                item['image'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}