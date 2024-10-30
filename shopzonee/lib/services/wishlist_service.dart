import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopzonee/model/product_model.dart';
import 'package:shopzonee/model/wishlistmodel.dart';
import 'package:shopzonee/utils/apiconst.dart';

class WishlistService {
  Future<List<WishlistModel>> viewwishlist() async {
    final String url = '$baseUrl/viewwishlist/';

    try {
      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        final wishlistdata = jsonResponse['data'];

        final wishlistList = wishlistdata
            .map<WishlistModel>((json) => WishlistModel.fromJson(json))
            .toList();

        return wishlistList;
      } else {
        final decodedBody = jsonDecode(response.body);
        final message = decodedBody['message'] ?? 'Failed to load products';
        throw Exception('Error ${response.statusCode}: $message');
      }
    } catch (e) {
      throw Exception('Failed to add to favorites: $e');
    }
  }
}
