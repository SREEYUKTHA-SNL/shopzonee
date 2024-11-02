import 'dart:developer';

import 'package:shopzonee/model/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shopzonee/model/subcatmodel.dart';
import 'package:shopzonee/utils/apiconst.dart';

class SubcategoryService {
  Future<SubcategoryCategory?> fetchSubcategories({required int categoryId}) async {
    final response = await http.get(Uri.parse('$baseUrl/view-subcategories/category/$categoryId'));

    print('subcategories');


    

    if (response.statusCode == 200) {
      final data =  SubcategoryCategory.fromJson(json.decode(response.body));

      print(data);

      return data;
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<List<ProductModel>> fetchProductsByCategoryAndSubcategory({required int categoryId,required int subcategoryId}) async {
    final String url = '$baseUrl/viewproductsbycatsubcat/?category_id=$categoryId&subcategory_id=$subcategoryId';
    print(url);

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
  
       
         final data =   jsonResponse['data'].map<ProductModel>((item) => ProductModel.fromJson(item))
            .toList();

            print(data);

            return data;
      
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
