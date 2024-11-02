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
    // Make sure baseurl is defined correctly and ends with a slash
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
}