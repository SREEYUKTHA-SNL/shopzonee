import 'dart:convert'; // For jsonEncode
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shopzonee/model/category_model.dart';
import 'package:shopzonee/model/product_model.dart';
import 'package:shopzonee/model/user_model.dart';
import 'package:shopzonee/utils/apiconst.dart';

class ApiService {
  // Function to register a user
  Future<void> registerUser({
    required String name,
    required String password,
    required String email,
    required String number,
  }) async {
    final String url = '$baseUrl/registration/';

    // Prepare the registration data
    final Map<String, String> registrationData = {
      'name': name,
      'password': password,
      'email': email,
      'number': number
    };

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        body: registrationData,
      );

      if (response.statusCode == 200) {
        print('Registration successful: ${response.body}');
      } else {
        String message = jsonDecode(response.body)['message'];

        throw Exception(message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> loginUser({
    required String password,
    required String email,
  }) async {
    final String url = '$baseUrl/login/';

    // Prepare the registration data
    final Map<String, String> loginData = {
      'password': password,
      'email': email,
    };

    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        body: loginData,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return UserModel.fromJson(data['data']);
      } else {
        String message = jsonDecode(response.body)['message'];

        throw Exception(message);
      }
    } catch (e) {
      rethrow;
    }
  }

 



  // Function to fetch products from the API
  Future<List<ProductModel>> fetchProducts() async {
    final String url = '$baseUrl/viewproduct/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        final products = jsonResponse['data'];

        final productList = products
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();

        return productList;
      } else {
        // Decode the error response more safely
        final decodedBody = jsonDecode(response.body);
        final message = decodedBody['message'] ?? 'Failed to load products';
        throw Exception('Error ${response.statusCode}: $message');
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    final response = await http.post(
      Uri.parse('$baseUrl/search/'),
      body: jsonEncode({'search_query': query}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } else {
      throw Exception('No products found');
    }
  }

  Future<void> addToFavorites(
      {required String userid, required String productid}) async {
    final String url = '$baseUrl/addwishlist/';

    final Map<String, String> favoriteData = {
      'userid': userid,
      'productid': productid,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: favoriteData,
      );

      if (response.statusCode == 200) {
        print('Product added to favorites: ${response.body}');
      } else {
        String message = jsonDecode(response.body)['message'];
        throw Exception('Error ${response.statusCode}: $message');
      }
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }
}