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
                // Header Drawer dengan Gradient
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.pinkAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.local_hospital,
                          size: 35,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Admin Posyandu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Posyandu Melati RW 05',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                // Menu Dashboard
                _buildDrawerItem(
                  context: context,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  index: 0,
                ),

                // Menu Jadwal Posyandu
                _buildDrawerItem(
                  context: context,
                  icon: Icons.calendar_today,
                  title: 'Jadwal Posyandu',
                  index: 1,
                ),

                // Menu Data Balita
                _buildDrawerItem(
                  context: context,
                  icon: Icons.child_care,
                  title: 'Data Balita',
                  index: 2,
                ),

                // Menu Data Ibu Hamil
                _buildDrawerItem(
                  context: context,
                  icon: Icons.pregnant_woman,
                  title: 'Data Ibu Hamil',
                  index: 3,
                ),

                // Menu Laporan
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.pink),
                  title: const Text('Laporan'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigasi ke halaman Laporan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur Laporan segera hadir')),
                    );
                  },
                ),

                // Menu Stok Obat & Vitamin
                ListTile(
                  leading: const Icon(Icons.inventory, color: Colors.pink),
                  title: const Text('Stok Obat & Vitamin'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigasi ke halaman Stok
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur Stok segera hadir')),
                    );
                  },
                ),

                // Menu Notifikasi Imunisasi
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.pink),
                  title: const Text('Notifikasi Imunisasi'),
                  trailing: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '8',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigasi ke halaman Notifikasi
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('8 Notifikasi Imunisasi')),
                    );
                  },
                ),

                const Divider(),

                // Menu Bantuan
                ListTile(
                  leading: const Icon(Icons.help_outline, color: Colors.pink),
                  title: const Text('Bantuan'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigasi ke halaman Bantuan
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Halaman Bantuan')),
                    );
                  },
                ),

                // Menu Tentang Aplikasi
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.pink),
                  title: const Text('Tentang Aplikasi'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
          ),

          // Bagian bawah drawer (logout)
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Konfirmasi Logout"),
                  content: const Text("Apakah Anda yakin ingin logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // tutup dialog
                      },
                      child: const Text("Batal"),
                    ),
                    TextButton(
                      onPressed: () async {
                        await PreferencesHandler.removeLogin();
                        await PreferencesHandler.saveRole('');
                        Navigator.of(context).pop(); // tutup dialog
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // Widget helper untuk item drawer dengan navigasi
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pop(context); // tutup drawer
        // Pindah ke halaman sesuai index via BottomNav
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNav(initialIndex: index),
          ),
        );
      },
    );
  }

  // Dialog Tentang Aplikasi
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: const [
            Icon(Icons.local_hospital, color: Colors.pink),
            SizedBox(width: 8),
            Text("Posyandu Digital"),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Versi 1.0.0",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Aplikasi untuk mengelola data posyandu secara digital, termasuk data balita, ibu hamil, jadwal posyandu, dan imunisasi.",
            ),
            SizedBox(height: 12),
            Text(
              "© 2024 Posyandu Digital",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }
}