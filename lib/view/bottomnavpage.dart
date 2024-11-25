import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopzonee/services/shared_pref.dart';
import 'package:shopzonee/utils/colors.dart';
import 'package:shopzonee/view/discoverpage.dart';
import 'package:shopzonee/view/homepage.dart';
import 'package:shopzonee/view/profilepage.dart';
import 'package:shopzonee/view/your_cart.dart';

class BottomNavigationPage extends StatefulWidget {
  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    DiscoverPage(),
    YourCart(),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void initState() {

    context.read<UserProvider>().loadLoginId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 30,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.category),
              icon: Icon(Icons.category_outlined),
              label: 'categories',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.shopping_bag),
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          selectedItemColor: kPrimary,
          unselectedItemColor: kSecondary,
          type: BottomNavigationBarType.fixed,

          // Inactive item color
        ),
      ),
    );
  }
}
