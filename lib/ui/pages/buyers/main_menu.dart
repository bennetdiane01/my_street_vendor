import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:my_street_vendor/ui/pages/buyers/favorite_page.dart';
import 'package:my_street_vendor/ui/pages/buyers/map_page.dart';
import 'package:my_street_vendor/ui/pages/general/profile_page.dart';
import 'package:my_street_vendor/ui/shared/variables.dart';


class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    MapPage(),
    FavoritePage(),
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
            icon: Icon(Feather.heart),
            label: 'Favorite',
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
