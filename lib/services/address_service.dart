import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopzonee/model/addressmodel.dart';
import 'package:shopzonee/utils/apiconst.dart';

class AddressService {
  // Function to add an address
  Future<Map<String, dynamic>> addAddress(Address address) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/addaddress/'),
        body: address.toJson(),
      );

      

      print(response.body);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['success'] == 1) {
          return {'success': true};
        } else {
          return {'success': false, 'error': body['message']};
        }
      } else {
        return {'success': false, 'error': 'Failed to add address'};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }

  // Function to view address
  Future<Map<String, dynamic>> viewAddress(String loginId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/viewsingleaddress/$loginId'),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        print(body);

        List<Address> addresses =
            body.map<Address>((json) => Address.fromJson(json)).toList();

        print(addresses);

        return {'success': true, 'data': addresses};
      } else {
        return {'success': false, 'error': 'Failed to fetch address data'};
      }
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }





}
