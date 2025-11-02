import 'package:flutter/material.dart';
import 'package:project_ppkd/preferences/preferences_handler.dart';
import 'package:project_ppkd/view/bottom_nav.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Bagian atas drawer (header + menu)
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text(
                    "Admin Panel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.dashboard, color: Colors.blue),
                  title: const Text(
                    'Dashboard Admin',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.pop(context); // tutup drawer
                    // Pindah ke dashboard (index 0) via BottomNav
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNav(initialIndex: 0),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: const Text(
                    'Profil Admin',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onTap: () {
                    Navigator.pop(context); // tutup drawer
                    // Pindah ke profil admin (index 1) via BottomNav
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNav(initialIndex: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Bagian bawah drawer (logout)
          // Divider(height: 1),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Konfirmasi Logout"),
                  content: Text("Apakah Anda yakin ingin logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // tutup dialog
                      },
                      child: Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await PreferencesHandler.removeLogin();
                        Navigator.of(context).pop(); // tutup dialog
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                      child: Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}