import 'package:flutter/material.dart';
import 'package:shopzonee/model/product_model.dart';
import 'package:shopzonee/model/wishlistmodel.dart';
import 'package:shopzonee/services/api_service.dart';
import 'package:shopzonee/services/wishlist_service.dart';
// Assuming the model class is stored in the `model` folder

class ProductProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  final  WishlistService wishlistService=WishlistService();
  List<ProductModel> products = [];
  List<WishlistModel> whishListProduct = [];
  bool isLoading = false;
  String? errorMessage;

  // Getter for products
  List<ProductModel> get productss => products;

  // Getter for loading state
  bool get isLoadings => isLoading;

  // Getter for error message
  String? get errorMessages => errorMessage;

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await apiService.fetchProducts();
      whishListProduct = await wishlistService.viewwishlist(); // Fetch data from the service


      // Convert to Data model list
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> addtowishlist({required String userid, required String productid}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Convert to Data model list
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  


  bool  checkFav(int pid){
  ;

   final isFav = whishListProduct.any((element) {
   
    return element.productid == pid.toString(); });
  ;

  return isFav;


  }
}
