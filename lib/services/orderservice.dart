import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopzonee/utils/apiconst.dart';

class OrderService {
  Future<Map<String, dynamic>> placeOrder(
      String userId, List cartidList) async {
    final url = Uri.parse('$baseUrl/order/$userId');

    final body = {
      'cart_ids': cartidList,
    };

    print(cartidList);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      print(response.body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to place order');
      }
    } catch (e) {
      throw Exception('Error placing order: $e');
    }
  }

  Future<Map<String, dynamic>> fetchOrder(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/OrderViewApi/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load order');
    }
  }
}
