import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    List<bool> selectedItems = [];

  List<CartModel> get cartItems => _cartItems;

  Future<void> addToCart({required String productid, required String userId}) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final result = await _cartService.addToCart(productid: productid, userId: userId);
print(result);
      if (result['success']) {
        SharedPreferences prefs=await SharedPreferences.getInstance();
                  String? loginId=await prefs.getString('loginId');
                  print(loginId);
        
        _success = true;
        _message = "Item added to cart successfully!";
        await fetchCartItems(int.parse(loginId!)); // Refresh cart items
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

  Future<void> fetchCartItems(int userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _cartItems = await _cartService.fetchCartItems(userId);

      selectedItems = List<bool>.filled(_cartItems.length, false);
      notifyListeners();
  

    } catch (error) {
      print("Error fetching cart items: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Function to delete a cart item
  Future<void> deleteCartItem({ required String cartItemId}) async {
    _isLoading = true;
    _message = '';
    notifyListeners();

    try {
      final result = await _cartService.deleteCartItem(cartItemId: cartItemId);
      SharedPreferences prefs=await SharedPreferences.getInstance();
                  String? loginId=await prefs.getString('loginId');

      if (result['success']) {
        _success = true;
        _message = "Item deleted from cart successfully!";
        
        await fetchCartItems(int.parse(loginId!)); // Refresh cart items after deletion
      } else {
        _success = false;
        _message = "Failed to delete item from cart: ${result['error']}";
      }
    } catch (e) {
      _success = false;
      _message = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
double totalPrice = 0.0;

  // Add a method to calculate the total price
void calculateTotalPrice() {
  totalPrice = 0.0;
  for (int i = 0; i < cartItems.length; i++) {
    if (selectedItems[i]) { 
      double itemPrice = double.tryParse(cartItems[i].price.toString()) ?? 0.0;
      int itemQuantity = int.tryParse(cartItems[i].quantity.toString()) ?? 1;
      totalPrice += itemPrice * itemQuantity;
    }
  }
  notifyListeners();  
}

Future<void> incrementItemQuantity(String productid, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (await _cartService.incrementItemQuantity(productid, userId)) {
        _updateItemQuantity(productid, 1);
      } else {
        throw Exception("Failed to increment item");
      }
    } catch (e) {
      print(e); 
    }

    _isLoading = false;
    notifyListeners();
}
Future<void> decrementItemQuantity(String productid, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (await _cartService.decrementItemQuantity(productid, userId)) {
        _updateItemQuantity(productid, -1);
      } else {
        throw Exception("Failed to decrement item");
      }
    } catch (e) {
      print(e); 
    }

    _isLoading = false;
    notifyListeners();
  }


  void _updateItemQuantity(String productid, int change) {
    for (var item in _cartItems) {
      if (item.productid == productid) {
          final currentQuantity = int.tryParse(item.quantity.toString()) ?? 0;
        item.quantity = currentQuantity.toString() + change.toString();
        notifyListeners();
        break;
      }
    }
  }


}




