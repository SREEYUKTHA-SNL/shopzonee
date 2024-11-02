import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view/favpage.dart';
import 'package:shopzonee/view/product_full.dart';
import 'package:shopzonee/view_model/fav_viewmodel.dart';
import 'package:shopzonee/view_model/fetchproduct_viewmodel.dart';

class Allproductspage extends StatefulWidget {
  Allproductspage({super.key});

  @override
  State<Allproductspage> createState() => _AllproductspageState();
}

class _AllproductspageState extends State<Allproductspage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
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
                context.read<ProductProvider>().fetchProducts();
              },
              icon: Icon(Icons.favorite, color: Colors.red),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 231, 223, 223).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  onChanged: (query) {
                    
  
                    context.read<ProductProvider>().searchProducts(query);
                  },
                ),
              ),
            ),
            Expanded(
              child: Consumer<ProductProvider>(
                builder: (context, productProvider, child) {
                  if (productProvider.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (productProvider.errorMessage != null) {
                    return Center(
                      child: Text(
                        'Error: ${productProvider.errorMessage}',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (productProvider.products.isEmpty) {
                    return Center(child: Text('No products available'));
                  } else {
                    final products = productProvider.products;
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductFull(product: product),
                                ),
                              );
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
                                        height: 250,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              
                                              product.image ?? ''),
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
                                              context.read<ProductProvider>().fetchProducts();
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
          ],
        ),
      ),
    );
  }
}
