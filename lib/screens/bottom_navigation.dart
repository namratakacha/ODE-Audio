import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/Pages/account.dart';
import 'package:music_player/Pages/library.dart';
import 'package:music_player/Pages/podcast.dart';
import 'package:music_player/Pages/radio.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedIndex = 0;

  List<Widget> barPages = <Widget>[
    LibraryPage(),
    RadioPage(),
    PodcastPage(),
    MyAccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: barPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_music_sharp,
              ),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wifi_tethering),
              label: 'Radio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              label: 'Poadcast',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'My Account',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.lightBlue.shade100.withOpacity(0.7),
          backgroundColor: Colors.lightBlue,
          iconSize: 29,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
