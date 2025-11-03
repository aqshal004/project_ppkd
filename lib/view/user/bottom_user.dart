import 'package:flutter/material.dart';
import 'package:project_ppkd/view/user/dashboard.dart';
import 'package:project_ppkd/view/user/jadwal_user.dart';
import 'package:project_ppkd/view/user/profil_user.dart';
import 'package:project_ppkd/view/user/riwayat_user.dart';

class BottomNavUser extends StatefulWidget {
  const BottomNavUser({Key? key}) : super(key: key);

  @override
  State<BottomNavUser> createState() => _BottomNavUserState();
}

class _BottomNavUserState extends State<BottomNavUser> {
  int _currentIndex = 0;

  // List of pages untuk setiap tab
  final List<Widget> _pages = [
    const DashboardWidget(),
    const JadwalPage(),
    const RiwayatUser(),
    const ProfilUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
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
          selectedItemColor: Colors.teal.shade600,
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
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.calendar_month_outlined, 1),
              activeIcon: _buildIcon(Icons.calendar_month, 1, active: true),
              label: 'Jadwal',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.assignment_outlined, 2),
              activeIcon: _buildIcon(Icons.assignment, 2, active: true),
              label: 'Riwayat',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.person_outline, 3),
              activeIcon: _buildIcon(Icons.person, 3, active: true),
              label: 'Profil',
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
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: Icon(
        icon,
        size: 26,
      ),
    );
  }
}

