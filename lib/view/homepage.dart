import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/routes/routes.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/widget/productcard.dart';
import 'package:shopzonee/view_model/fetchproduct_viewmodel.dart'; // Import your ProductProvider
import 'package:flutter/services.dart'; // Import for SystemNavigator

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
      context.read<UserProvider>().loadLoginId();
    });
  }

  Future<bool> _onWillPop() async {
 
    SystemNavigator.pop();
    return false; 
  }

  @override
  Widget build(BuildContext context) {

    final productProvider = context.watch<ProductProvider>();

    return WillPopScope(
      onWillPop: _onWillPop, 
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text("Gemstore"),
          actions: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Stack(
                  alignment: Alignment.center, 
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/Mask Group (4).png',
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Overlay Text
                    Positioned(
                      right: 40,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Autumn \nCollection\n2024",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Featured Products",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.allproductpage);
                      },
                      child: Text("Show all",
                          style: TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                  ],
                ),
              ),

            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 300, 
                  child: productProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : productProvider.errorMessage != null
                          ? Center(child: Text('Error: ${productProvider.errorMessage}'))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productProvider.products.length < 3
                                  ? productProvider.products.length
                                  : 3,
                              itemBuilder: (context, index) {
                                final product = productProvider.products[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: ProductCard(
                                    imageUrl: product.image ?? '',
                                    productName: product.productname ?? 'No name',
                                    productPrice: product.price ?? 'No price',
                                  ),
                                );
                              },
                            ),
                ),
              ),
              Image.asset('assets/images/offer.png'),

              // New Section: Recommended Products
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Recommended",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),

              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 300, // Adjust the height as needed
                  child: productProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : productProvider.errorMessage != null
                          ? Center(child: Text('Error: ${productProvider.errorMessage}'))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productProvider.products.length > 3
                                  ? (productProvider.products.length - 3) < 4
                                      ? productProvider.products.length - 3 // If less than 4 remaining products, show all
                                      : 4 // Limit to 4 products
                                  : 0, // Only show products if more than 3 exist
                              itemBuilder: (context, index) {
                                final product = productProvider.products[index + 3];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: ProductCard(
                                    imageUrl: product.image ?? '',
                                    productName: product.productname ?? 'No name',
                                    productPrice: product.price ?? 'No price',
                                  ),
                                );
                              },
                            ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Top Collections',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset('assets/images/banner 1.png'),
              Image.asset('assets/images/banner 2.png'),
            ],
          ),
        ),
      ),
    );
  }
}
