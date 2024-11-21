import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopzonee/model/cart_model.dart';
import 'package:shopzonee/utils/apiconst.dart';

class CartService {
  // Base URL of your API

  // Function to add an item to the cart
  Future<Map<String, dynamic>> addToCart(
      {required String productid, required String userId}) async {
    try {
     
      final url = Uri.parse("$baseUrl/addcartapi/");
      print(url);

   
      final body = {
        'productid': productid,
        'userid': userId,
      };

      final response = await http.post(
        url,
        body: body,
      );

      print(response.body);

    
      if (response.statusCode == 200) {

        final data = json.decode(response.body);
        return {'success': true, 'data': data};
      } else {
     
        final errorData = json.decode(response.body);
        return {'success': false, 'error': errorData};
      }
    } catch (e) {
      // Handle exception
      return {'success': false, 'error': e.toString()};
    }
  }

  Future<List<CartModel>> fetchCartItems() async {
  
    final apiUrl = Uri.parse("$baseUrl/viewcart/"); // Replace with your API URL

    try {
      final response = await http.get(apiUrl); // No need to parse again
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        // Decode the JSON response
        
        final  jsonData = json.decode(response.body);

        // Convert the JSON data to a list of Cart objects
        return jsonData['data'].map<CartModel>((item) => CartModel.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to load cart items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load cart items: $e');
    }
  }

  Future<Map<String, dynamic>> deleteCartItem({required String cartItemId}) async {
  try {
 
    final url = Uri.parse("$baseUrl/deletercart/$cartItemId");
    print(url);


    final response = await http.delete(url);

    if (response.statusCode == 200) {

      final data = json.decode(response.body);
      return {'success': true, 'data': data};
    } else {
  
      final errorData = json.decode(response.body);
      return {'success': false, 'error': errorData};
    }
  } catch (e) {

    print('Error: $e');
    return {'success': false, 'error': e.toString()};
  }
}
Future<bool> incrementItemQuantity(String itemId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/increment_quantity/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'itemid': itemId, 'userid': userId}),
      );

      print('Increment Response: ${response.statusCode}, ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error incrementing item: $e');
      return false;
    }
  }

  Future<bool> decrementItemQuantity(String itemId, String userId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/decrement_quantity/"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'itemid': itemId, 'userid': userId}),
      );

      print('Decrement Response: ${response.statusCode}, ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error decrementing item: $e');
      return false;
    }
  }

}