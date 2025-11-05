import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:project_ppkd/view/dashboard_admin.dart';
import 'package:project_ppkd/view/drawer.dart';
import 'package:project_ppkd/view/profil_admin.dart';
// Import halaman-halaman baru untuk posyandu
// import 'package:project_ppkd/view/jadwal_posyandu.dart';
// import 'package:project_ppkd/view/data_balita.dart';
// import 'package:project_ppkd/view/data_ibu_hamil.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex; // ✅ Parameter untuk set index awal
  
  const BottomNav({super.key, this.initialIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _selectedIndex;

  // ✅ Daftar halaman untuk bottom navigation (5 halaman)
  static const List<Widget> _widgetOptions = <Widget>[
    DashboardAdminWidget(),     // 0 - Home/Dashboard
      // 4 - Pengaturan/Profil
  ];

  // ✅ Daftar judul untuk AppBar
  static const List<String> _titles = [
    'Dashboard Posyandu',
    'Jadwal Posyandu',
    'Data Balita',
    'Data Ibu Hamil',
    'Pengaturan',
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
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: _widgetOptions[_selectedIndex],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.pink,
        buttonBackgroundColor: Colors.pinkAccent,
        height: 60,
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.calendar_today, color: Colors.white),
            label: 'Jadwal',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.child_care, color: Colors.white),
            label: 'Balita',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.pregnant_woman, color: Colors.white),
            label: 'Ibu Hamil',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings, color: Colors.white),
            label: 'Setting',
            labelStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
