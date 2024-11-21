import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shopzonee/model/addressmodel.dart';
import 'package:shopzonee/view_model/adrdeess_viewmodel.dart';

class EditAddressScreen extends StatefulWidget {
  final int loginId; // User ID parameter
  final Address address;

  EditAddressScreen({required this.loginId, required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController nameController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController houseNoController;
  late TextEditingController pincodeController;
  late TextEditingController districtController;
  late TextEditingController phonenumberController;



  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.address.name);
    streetController = TextEditingController(text: widget.address.street);
    cityController = TextEditingController(text: widget.address.city);
    stateController = TextEditingController(text: widget.address.state);
    houseNoController = TextEditingController(text: widget.address.houseNo.toString());
    pincodeController = TextEditingController(text: widget.address.pincode.toString());
    districtController = TextEditingController(text: widget.address.district);
    phonenumberController = TextEditingController(text: widget.address.phonenumber.toString());


  }

  @override
  void dispose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    districtController.dispose();
    pincodeController.dispose();
    houseNoController.dispose();
    phonenumberController.dispose();

    super.dispose();
  }

  void _saveAddress() async {
    final updatedAddress = Address(
      id: widget.address.id,
      name: nameController.text,
      street: streetController.text,
      city: cityController.text,
      state: stateController.text,
      district: districtController.text,
      pincode: pincodeController.text,
      houseNo: houseNoController.text,
      phonenumber:phonenumberController.text

    );
    print(widget.address.id);

    final addressViewModel = Provider.of<AddressViewModel>(context, listen: false);

    await addressViewModel.updateAddress(widget.loginId.toString(), updatedAddress,context);
    print(widget.loginId);

    if (addressViewModel.errorMessage == null) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address updated successfully')),
      );
      Navigator.pop(context); // Go back after successful update
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(addressViewModel.errorMessage ?? 'Failed to update address')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final addressViewModel = Provider.of<AddressViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: addressViewModel.isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.green))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: streetController,
                    decoration: InputDecoration(
                      labelText: 'Street',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: cityController,
                    decoration: InputDecoration(
                      labelText: 'City',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: stateController,
                    decoration: InputDecoration(
                      labelText: 'State',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: districtController,
                    decoration: InputDecoration(
                      labelText: 'district',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: pincodeController,
                    decoration: InputDecoration(
                      labelText: 'Postal Code',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: phonenumberController,
                    decoration: InputDecoration(
                      labelText: 'Phonenumber',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: houseNoController,
                    decoration: InputDecoration(
                      labelText: 'HouseNo',
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveAddress,
                    child: Text('Save'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}