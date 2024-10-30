import 'package:flutter/material.dart';
import 'package:shopzonee/model/product_model.dart';
import 'package:shopzonee/model/wishlistmodel.dart';
import 'package:shopzonee/services/api_service.dart';
import 'package:shopzonee/services/wishlist_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  List<WishlistModel> _favoriteProducts = [];
  bool _isLoading = false;

  List<WishlistModel> get favoriteProducts => _favoriteProducts;
  bool get isLoading => _isLoading;

  Future<void> addProductToFavorites(int productid, String userid) async {
   
      try {
        await apiService.addToFavorites(
          productid: productid.toString(),
          userid: userid,
        );
        notifyListeners();
      } catch (error) {
        print('Error adding to favorites: $error');
        _favoriteProducts.remove(productid);
        notifyListeners();
      }
    
  }

  void removeProductFromFavorites(int product) {
    _favoriteProducts.removeWhere((favProduct) => favProduct.id == product);
    notifyListeners();
  }

  bool isFavorite(int productid) {
    return _favoriteProducts.any((favProduct) => favProduct.id == productid);
  }

  void toggleFavorite(int productid, String userid) {
  
      addProductToFavorites(productid, userid);
      viewwishlists();
    
  }

  Future<void> viewwishlists() async {
    

    try {
      _isLoading = true;
      notifyListeners();
      _favoriteProducts = await WishlistService().viewwishlist();
      
    } catch (error) {
     print( "Error fetching wishlist: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
   
    }
  }
}
