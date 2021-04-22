import 'package:flutter/material.dart';
import 'package:rick_and_morty/settings.dart';

import 'characters/personProvider.dart';
import 'episodes/episodesProvider.dart';
import 'locations/locationsProvider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Settings.backgroundColor,
        appBar: AppBar(
          title: Text(_titleText()),
        ),
        bottomNavigationBar: _bottomNavigationBar(),
    body: _widgetOptions[_selectedIndex],
      );

  BottomNavigationBar? _bottomNavigationBar() => BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.grey[900],
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'Episodes',
          ),
        ],
      );

  String _titleText() {
    switch(_selectedIndex) {
      case 0: return "All characters";
      case 1: return "Locations";
      case 2: return "Episodes";
    }
    return "Error";
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    PersonProvider(),
    LocationsProvider(),
    EpisodesProvider(),
  ];
}
