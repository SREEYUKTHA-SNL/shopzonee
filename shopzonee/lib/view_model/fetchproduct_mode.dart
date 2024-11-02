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


  // Getter for products
  List<ProductModel> get productss => products;

  // Getter for loading state
  bool get isLoadings => isLoading;

  // Getter for error message
  String? get errorMessages => errorMessage;

  // Getter for subcategories
 // List<Data> get subcategoriesList => subcategories;

  Future<void> fetchProducts() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      products = await apiService.fetchProducts();
      
      
       // Fetch products
      whishListProduct = await wishlistService.viewwishlist(); 

      
      
      // Fetch wishlist items
    } catch (e) {
      
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

   Future<void> searchProducts(String query) async {
    isLoading = true;
    notifyListeners();
    try {
      products = await ApiService().searchProducts(query);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'No products found';
    }
    isLoading = false;
    notifyListeners();
  }

  // bool checkFav(int productId) {
  //   return products.any((product) => product.id == productId && product.isFavorite);
  // }



  Future<void> addtowishlist({required String userid, required String productid}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // Implement the add to wishlist logic here
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


Future<void> fetchProductsbycatandsubcat({required int categoryId,required int subcategoryId}) async {
  print('subcategory');
  print(categoryId);
  print(subcategoryId);


    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      subproducts = await subcategoryService.fetchProductsByCategoryAndSubcategory(categoryId:  categoryId,subcategoryId:  subcategoryId);
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
       subcategoryData = await subcategoryService.fetchSubcategories(categoryId: catid); // Fetch subcategories from the service
     
     // Assign data to local subcategories list
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool checkFav(int pid) {
    // Check if any product in the wishlist matches the product id
    return whishListProduct.any((item) => item.productid == pid.toString());
  }
}
