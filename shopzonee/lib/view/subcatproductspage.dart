import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view/favpage.dart';
import 'package:shopzonee/view_model/fav_provider.dart';
import 'package:shopzonee/view_model/fetchproduct_mode.dart';
// Assuming the model class is stored in the `model` folder

class SubcatproductPage extends StatefulWidget {
  SubcatproductPage({super.key, required this.categoryId, required this.subcategoryId});
  final int categoryId;
  final int subcategoryId;

  @override
  State<SubcatproductPage> createState() => _SubcatproductPageState();
}

class _SubcatproductPageState extends State<SubcatproductPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProductsbycatandsubcat(
            categoryId: widget.categoryId,
            subcategoryId: widget.subcategoryId,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesPage(),
                  ),
                );
                // Fetch products again to refresh the favorite status
                context.read<ProductProvider>().fetchProducts();
              },
              icon: Icon(Icons.favorite, color: Colors.red),
            ),
          ],
        ),
        body: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            if (productProvider.isLoading) {
              // Show a loading indicator while fetching products
              return Center(child: CircularProgressIndicator());
            } else if (productProvider.errorMessage != null) {
              // Show an error message if fetching products fails
              return Center(
                child: Text(
                  'Error: ${productProvider.errorMessage}',
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (productProvider.subproducts.isEmpty) {
              // Show a message if no products are available
              return Center(child: Text('No products available'));
            } else {
              // Display the products in a GridView
              final products = productProvider.subproducts;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isFavorite = context.watch<ProductProvider>().checkFav(product.id!);

                    return GestureDetector(
                      onTap: () {
                        // Navigate to product details page if needed
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  height: 250.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                      image: NetworkImage(product.image ?? ''),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      icon: Icon(
                                        isFavorite ? Icons.favorite : Icons.favorite_border,
                                        color: isFavorite ? Colors.red : Colors.grey[400],
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        final userid = Provider.of<UserProvider>(context, listen: false).userId;

                                        context.read<FavoritesProvider>().toggleFavorite(product.id!, userid!, index);
                                        context.read<ProductProvider>().fetchProducts(); // Refresh product list
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productname ?? 'No name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  product.price ?? 'No price',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
