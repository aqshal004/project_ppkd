import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:project_ppkd/view/dashboard_admin.dart';
import 'package:project_ppkd/view/drawer.dart';
import 'package:project_ppkd/view/profil_admin.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex; // ✅ Tambah parameter untuk set index awal
  
  const BottomNav({super.key, this.initialIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardAdminWidget(),
    ProfilAdmin(),
    ProfilAdmin(), // Ganti dengan widget Setting jika ada
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Set index awal dari parameter
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),

      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Dashboard' : _selectedIndex == 1 ? 'Profil Admin' : _selectedIndex == 2 ? 'Setting' : ''),
      ),

      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.person_outline),
            label: 'Profil',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings_outlined),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}