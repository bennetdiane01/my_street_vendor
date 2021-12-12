import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

import 'package:my_street_vendor/ui/pages/general/profile_page.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_map.dart';
import 'package:my_street_vendor/ui/pages/vendors/vendor_request.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';
class VendorMenu extends StatefulWidget {
  const VendorMenu({Key? key}) : super(key: key);

  @override
  _VendorMenuState createState() => _VendorMenuState();
}

class _VendorMenuState extends State<VendorMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    VendorMap(),
    VendorRequest(),
    ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Feather.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.git_pull_request),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        //selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
