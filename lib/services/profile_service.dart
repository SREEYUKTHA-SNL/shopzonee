import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopzonee/model/profile_model.dart';


class Profileservice {
  static const String baseUrl = 'https://shopzoneapi.onrender.com';

  Future<Profile?> fetchUserDetails(int userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/viewsingleusers/$userId'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Profile.fromJson(data);
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }
}