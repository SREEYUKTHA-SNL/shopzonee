import 'package:flutter/material.dart';
import 'package:shopzonee/model/product_model.dart';

import 'package:shopzonee/model/subcatmodel.dart';
import 'package:shopzonee/model/wishlistmodel.dart';
import 'package:shopzonee/services/api_service.dart';
import 'package:shopzonee/services/subcategory_service.dart';

import 'package:shopzonee/services/wishlist_service.dart';
// Assuming the model class is stored in the `model` folder

class ProductProvider with ChangeNotifier {
  final ApiService apiService = ApiService();
  final WishlistService wishlistService = WishlistService();

  // Initialize the SubcategoryService

  List<ProductModel> products = [];
  List<ProductModel> subproducts = [];
  List<WishlistModel> whishListProduct = [];
  // List<Data> subcategories = []; // List to hold fetched subcategories
  bool isLoading = false;
  String? errorMessage;
  final SubcategoryService subcategoryService = SubcategoryService();
  SubcategoryCategory? subcategoryData;
  List<ProductModel> get productss => products;
  bool get isLoadings => isLoading;
  String? get errorMessages => errorMessage;

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await apiService.fetchProducts();


      whishListProduct = await wishlistService.viewwishlist();

  
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

   Future<void> searchProducts(String query) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Fetch search results from ApiService and update the product list
      products = await apiService.searchProducts(query);
      errorMessage = null; // Reset any previous error messages
    } catch (e) {
      // Update error message if no products found or there's another error
      errorMessage = e.toString();
      products = []; // Clear products to show an empty state in the UI if needed
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addtowishlist(
      {required String userid, required String productid}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
  
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsbycatandsubcat(
      {required int categoryId, required int subcategoryId}) async {
    print('subcategory');
    print(categoryId);
    print(subcategoryId);

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      subproducts =
          await subcategoryService.fetchProductsByCategoryAndSubcategory(
              categoryId: categoryId, subcategoryId: subcategoryId);
      whishListProduct = await wishlistService.viewwishlist();

      print('view$subproducts');
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSubcategories(int catid) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      subcategoryData = await subcategoryService.fetchSubcategories(
          categoryId: catid); 

     
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool checkFav(int pid) {

    return whishListProduct.any((item) => item.productid == pid.toString());
  }
}
