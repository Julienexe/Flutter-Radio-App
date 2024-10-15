import 'package:flutter/material.dart';
import 'package:radio_app/admin/admin_page.dart';
import 'package:radio_app/main.dart';
import 'package:radio_app/radio/radio_list.dart';
import 'package:radio_app/schedule/schedule.dart';
import 'package:radio_app/settings/settings_page.dart';
import 'package:radio_app/video/video_streaming_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int _selectedIndex = 0;
  final BottomNavigationBarType _bottomNavType =
      BottomNavigationBarType.shifting;
  @override
  Widget build(BuildContext context) {
    //print(Uri.parse("https://player.castr.com/live_34f30f70f4f611edab1809312648496c"));
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            RadioList(),
           VideoWebViewPage(
      
            ),
            SchedulePage(),
            AdminRadioProgramPage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: bgcolor,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color(0xff757575),
          type: _bottomNavType,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: _navBarItems),
    );
  }
}

const _navBarItems = [
  BottomNavigationBarItem(
    backgroundColor: bgcolor,
    icon: Icon(Icons.radio_outlined),
    activeIcon: Icon(Icons.radio_rounded),
    label: 'Radio',
  ),
  BottomNavigationBarItem(
    backgroundColor: bgcolor,
    icon: Icon(Icons.play_circle_outline),
    activeIcon: Icon(Icons.play_circle_rounded),
    label: 'Video',
  ),
  BottomNavigationBarItem(
    backgroundColor: bgcolor,
    icon: Icon(Icons.calendar_month_outlined),
    activeIcon: Icon(Icons.calendar_month_rounded),
    label: 'Schedule',
  ),
  BottomNavigationBarItem(
    backgroundColor: bgcolor,
    icon: Icon(Icons.add_circle_outline),
    activeIcon: Icon(Icons.add_circle_rounded),
    label: 'Add Content',
  ),
  BottomNavigationBarItem(
    backgroundColor: bgcolor,
    icon: Icon(Icons.settings_outlined),
    activeIcon: Icon(Icons.settings_rounded),
    label: 'Settings',
  ),
];
