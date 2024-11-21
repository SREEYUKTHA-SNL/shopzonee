import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view_model/fav_viewmodel.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesProvider>().viewwishlists();
    });
  }

  int? checkIndex;

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = context.watch<FavoritesProvider>();
    final favoriteProducts = favoritesProvider.favoriteProducts;
    final isLoading = favoritesProvider.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No favorite products yet.'))
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          // Product Image
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(product.image ??
                                    'assets/images/default.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productname ?? 'Unknown Product',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.price ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Favorite Icon

                          favoritesProvider.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : IconButton(
                                  icon: const Icon(Icons.favorite,
                                      color: Colors.red),
                                  onPressed: () {
                                    checkIndex = index;

                                    final userid =
                                        context.read<UserProvider>().loginId;

                                    favoritesProvider.toggleFavorite(
                                        int.parse(product.productid!),
                                        userid!,
                                        index);
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
