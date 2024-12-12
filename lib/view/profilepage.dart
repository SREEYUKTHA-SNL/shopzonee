import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/view/addrrssdetails.dart';
import 'package:shopzonee/view/favpage.dart';
import 'dart:io';

import 'package:shopzonee/view/orderpage.dart';
import 'package:shopzonee/view/signinpage.dart';
import 'package:shopzonee/view_model/profile_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage; 
  final ImagePicker _picker = ImagePicker(); 
  

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, 
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void>_fetchUserDetails()async{
     final id = context.read<UserProvider>().loginId;
     Provider.of<ProfileViewModel>(context,listen: false).fetchUserDetails(int.tryParse(id!)!);
  }
@override
  void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _fetchUserDetails();
  });
}
  @override
  Widget build(BuildContext context) {
    final profileViewModel=Provider.of<ProfileViewModel>(context);
    final user=profileViewModel.user;
    print(user);
    final isloading=profileViewModel.isLoading;
    final errormessage=profileViewModel.errorMessage;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body:isloading?Center(child: CircularProgressIndicator(),):errormessage!=null?Center(child: Text(errormessage),): user==null?Center(child: Text('No user data available'),)
      : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    GestureDetector(
                      onTap: _pickImage, 
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null, 
                        child: _profileImage == null
                            ? Icon(Icons.person, size: 40, color: Colors.white)
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      user.email!,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView(
              children: [
                _buildProfileOption(
                  context,
                  icon: Icons.location_on,
                  title: 'Address',
                  onTap: () async{
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                  String? loginId=await prefs.getString('loginId');
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Viewaddress(loginId: int.tryParse(loginId!)!,)),
                    );
         
                  },
                ),
                _buildProfileOption(
                  context,
                  icon: Icons.payment,
                  title: 'Payment method',
                  onTap: () {},
                ),
                _buildProfileOption(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  title: 'My Orders',
                  onTap: () async{
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                  String? loginId=await prefs.getString('loginId');
                     Navigator.push(
                      

                      context,
                      MaterialPageRoute(builder: (context) => OrderDetailsPage(userId: int.tryParse(loginId!)! ,)),
                    );

                  },
                ),
                _buildProfileOption(
                  context,
                  icon: Icons.favorite,
                  title: 'My Wishlist',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritesPage()),
                    );
                  },
                ),
                _buildProfileOption(
                  context,
                  icon: Icons.star,
                  title: 'Rate this app',
                  onTap: () {},
                ),
                _buildProfileOption(
                  context,
                  icon: Icons.logout,
                  title: 'Log out',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage(),));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title),
        trailing: Icon(Icons.chevron_right, color: Colors.black),
        onTap: onTap,
      ),
    );
  }
}
