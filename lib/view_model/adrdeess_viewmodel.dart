import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopzonee/model/addressmodel.dart';
import 'package:shopzonee/services/address_service.dart';
import 'package:http/http.dart' as http;
import 'package:shopzonee/utils/apiconst.dart';



class AddressViewModel with ChangeNotifier {
  final AddressService _addressService = AddressService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Address> _addresses = [];
  List<Address> get addresses => _addresses;

  Address? _selectedAddress;
  Address? get selectedAddress => _selectedAddress;

  void selectAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
  }

  Future<void> addAddress({
    required String userid,
    required String name,
    required String phonenumber,
    required String houseNo,
    required String street,
    required String city,
    required String district,
    required String state,
    required String pincode,
  }) async {
    
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    Address address = Address(
      userid: int.parse(userid),
      name: name,
      phonenumber: phonenumber,
      houseNo: houseNo,
      street: street,
      city: city,
      district: district,
      state: state,
      pincode: pincode,
    );
    

    try {
      final response = await _addressService.addAddress(address);
      

      if (response['success'] == true) {
        fetchAddress(userid); // Refresh addresses
      } else {
        _errorMessage = response['error'] ?? 'Unknown error';
      }
    } catch (e) {
      _errorMessage = 'Failed to add address: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAddress(String loginId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _addressService.viewAddress(loginId);

      if (response['success'] == true) {
        _addresses = response['data'] ?? [];
      } else {
        _errorMessage = response['error'] ?? 'Failed to load addresses';
      }
    } catch (e) {
      _errorMessage = 'Error fetching address: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateAddress(
      String loginId, Address address, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final url = Uri.parse(
        '$baseUrl/updateaddress/${address.id}/'); 
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': address.name,
          'phonenumber':address.phonenumber,
          'street': address.street,
          'houseNo':address.houseNo,
          'city': address.city,
          'state': address.state,
          'country': address.district,
          'pincode': address.pincode,
        }),
      );

      if (response.statusCode == 200) {
        await fetchAddress(loginId);
        _errorMessage = null;
        notifyListeners();
      } else {
        _errorMessage = 'Failed to update address';
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = 'An error occurred: $error';
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> deleteAddress(int addressId, BuildContext context) async {
    final url =
        '$baseUrl/deleteaddress/$addressId/';
        print('kkkkkkkkkkkkkkkkkkkkkkkkkkk');

        print(addressId);

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final response = await http.delete(Uri.parse(url));
      print('Delete Response Status: ${response.statusCode}');
      print('Delete Response Body: ${response.body}');

      if (response.statusCode == 200) {
        _addresses.removeWhere((address) => address.id == addressId);
        if (context.mounted) {
          _showSnackBar(context, 'Address deleted successfully');
        }
      } else {
        _errorMessage = 'Failed to delete address: ${response.reasonPhrase}';
        print("Delete Error: $_errorMessage");
      }
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
      print("Exception during deleteAddress: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }


}
