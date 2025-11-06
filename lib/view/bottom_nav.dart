import 'package:flutter/material.dart';
import 'package:project_ppkd/view/admin/anak_page.dart';
import 'package:project_ppkd/view/dashboard_admin.dart';
import 'package:project_ppkd/view/drawer.dart';
import 'package:project_ppkd/view/profil_admin.dart';

class BottomNav extends StatefulWidget {
  final int initialIndex;

  const BottomNav({super.key, this.initialIndex = 0});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _currentIndex;

  final List<Widget> _pages = const [
    DashboardAdminWidget(),
    Center(child: Text("Jadwal Posyandu")),
    AnakPage(),
    Center(child: Text("Data Ibu Hamil")),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(_getTitle(_currentIndex)),
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey.shade400,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home_outlined, 0),
              activeIcon: _buildIcon(Icons.home, 0, active: true),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.calendar_month_outlined, 1),
              activeIcon: _buildIcon(Icons.calendar_month, 1, active: true),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.child_care_outlined, 2),
              activeIcon: _buildIcon(Icons.child_care, 2, active: true),
              label: 'Balita',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.pregnant_woman_outlined, 3),
              activeIcon:
                  _buildIcon(Icons.pregnant_woman, 3, active: true),
              label: 'Ibu Hamil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, int index, {bool active = false}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: active
          ? BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: Icon(
        icon,
        size: 26,
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "Dashboard Posyandu";
      case 1:
        return "Jadwal Posyandu";
      case 2:
        return "Data Balita";
      case 3:
        return "Data Ibu Hamil";
      case 4:
        return "Pengaturan";
      default:
        return "Posyandu";
    }
  }
}
