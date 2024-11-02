import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopzonee/model/category_model.dart';
import 'package:shopzonee/utils/apiconst.dart';

class CategoryService {
  Future<List<CategoryModel>> viewCategory() async {
    final String url = '$baseUrl/viewcategory/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          final List<dynamic> categoriesJson = jsonResponse['data'];
          
          // Map each JSON object to a CategoryModel object
          return categoriesJson
              .map((json) => CategoryModel.fromJson(json))
              .toList();
        } else {
          print("Failed to fetch categories: ${jsonResponse['message']}");
          return []; // Return an empty list if not successful
        }
      } else {
        throw Exception('Failed to fetch categories, Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching categories: $e");
      rethrow; // Pass error up if needed for higher-level handling
    }
  }
}
