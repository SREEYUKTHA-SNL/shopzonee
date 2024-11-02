import 'package:flutter/material.dart';
import 'package:shopzonee/model/cart_model.dart';
import 'package:shopzonee/services/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();

  bool _isLoading = false;
  String _message = '';
  bool _success = false;

  bool get isLoading => _isLoading;
  String get message => _message;
  bool get success => _success;

  List<CartModel> _cartItems = [];
  

  List<CartModel> get cartItems => _cartItems;
 

  

  // Method to add item to the cart
  Future<void> addToCart({
    required String productid,
    required String  userId
  }) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      // Call the API function to add item to the cart
     
      final result = await _cartService.addToCart(productid:productid ,userId:userId );

      if (result['success']) {
        _success = true;
        _message = "Item added to cart successfully!";
      } else {
        _success = false;
        _message = "Failed to add item to cart: ${result['error']}";
      }
    } catch (e) {
      _success = false;
      _message = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  

  Future<void> fetchCartItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await _cartService.fetchCartItems();
    } catch (error) {
      print("Error fetching cart items: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}