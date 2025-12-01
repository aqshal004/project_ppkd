import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ppkd/model/anak_firebase.dart';
import 'package:project_ppkd/service/firebase_anak.dart';
import 'package:project_ppkd/view/admin/input_jadwal.dart';
import 'package:project_ppkd/view/admin/tambah_anak.dart';


class DashboardAdminWidget extends StatelessWidget {
  const DashboardAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
          Card(
  elevation: 4,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15),
  ),
  child: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade600, Colors.greenAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Left
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.local_hospital,
            color: Colors.white,
            size: 40,
          ),
        ),

        const SizedBox(width: 16),

        // Texts
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang!',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Posyandu Melati RW 05',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Kelurahan Beji, Depok',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),

        // Tombol Logout
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: const Text("Konfirmasi Logout"),
                  content: const Text("Apakah Anda yakin ingin logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () async {
                        Navigator.pop(context); // Tutup dialog
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacementNamed('/login');
                      },
                      child: const Text("Logout", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.logout, color: Colors.white),
          tooltip: 'Logout',
        ),
      ],
    ),
  ),
),


            const SizedBox(height: 24),

            // Section Title
            const Text(
              'Ringkasan Data',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            StreamBuilder<List<AnakFirebase>>(
            stream: FirebaseAnakService.getAllAnakStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

          final dataAnak = snapshot.data!;
          final totalBalita = dataAnak.length;
            // Statistics Grid
             return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
              children: [
                _buildStatCard(
                  icon: Icons.child_care,
                  title: 'Total Balita',
                  value: totalBalita.toString(),
                  subtitle: '+5 bulan ini',
                  color: Colors.blue,
                  gradientColors: [Colors.blue, Colors.lightBlue],
                ),
               StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('jadwal_posyandu')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _buildStatCard(
            icon: Icons.calendar_today,
            title: 'Total Jadwal',
            value: '0',
            subtitle: 'Memuat...',
            color: Colors.purple,
            gradientColors: [Colors.purple, Colors.purpleAccent],
          );
        }

        final totalJadwal = snapshot.data!.docs.length;

        return _buildStatCard(
          icon: Icons.calendar_today,
          title: 'Total Jadwal',
          value: totalJadwal.toString(),
          subtitle: 'Jadwal terdaftar',
          color: Colors.purple,
          gradientColors: [Colors.purple, Colors.purpleAccent],
        );
      },
    ),
                // _buildStatCard(
                //   icon: Icons.vaccines,
                //   title: 'Imunisasi',
                //   value: '87',
                //   subtitle: 'Bulan ini',
                //   color: Colors.green,
                //   gradientColors: [Colors.green, Colors.lightGreen],
                // ),
                // _buildStatCard(
                //   icon: Icons.monitor_weight,
                //   title: 'Penimbangan',
                //   value: '124',
                //   subtitle: 'Bulan ini',
                //   color: Colors.orange,
                //   gradientColors: [Colors.orange, Colors.orangeAccent],
                //     ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // Quick Actions
            const Text(
              'Aksi Cepat',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.add_circle_outline,
                    title: 'Tambah Balita',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TambahDataAnak()),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickActionCard(
                    icon: Icons.calendar_month,
                    title: 'Input Jadwal',
                    color: Colors.pink,
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BuatJadwalPosyanduPage()),
                    );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Row(
            //   children: [
            //     Expanded(
            //       child: _buildQuickActionCard(
            //         icon: Icons.vaccines,
            //         title: 'Catat Imunisasi',
            //         color: Colors.green,
            //         onTap: () {},
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Expanded(
            //       child: _buildQuickActionCard(
            //         icon: Icons.description,
            //         title: 'Buat Laporan',
            //         color: Colors.orange,
            //         onTap: () {},
            //       ),
            //     ),
            //   ],
            // ),

            const SizedBox(height: 24),

            // Recent Activities
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kegiatan Terbaru',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildActivityCard(
              icon: Icons.vaccines,
              title: 'Imunisasi BCG',
              subtitle: 'Bayi Aisyah - 2 bulan',
              time: '10 menit lalu',
              color: Colors.green,
            ),
            _buildActivityCard(
              icon: Icons.monitor_weight,
              title: 'Penimbangan Balita',
              subtitle: 'Muhammad Rizki - 15 bulan (10.2 kg)',
              time: '25 menit lalu',
              color: Colors.blue,
            ),
            _buildActivityCard(
              icon: Icons.local_hospital,
              title: 'Pemeriksaan Ibu Hamil',
              subtitle: 'Ibu Siti - Usia kandungan 7 bulan',
              time: '1 jam lalu',
              color: Colors.purple,
            ),
            _buildActivityCard(
              icon: Icons.person_add,
              title: 'Pendaftaran Balita Baru',
              subtitle: 'Ahmad Fauzi - 6 bulan',
              time: '2 jam lalu',
              color: Colors.orange,
            ),

            const SizedBox(height: 24),

            // // Alerts Section
            // const Text(
            //   'Peringatan',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black87,
            //   ),
            // ),
            // const SizedBox(height: 12),

            // _buildAlertCard(
            //   icon: Icons.warning_amber_rounded,
            //   title: '8 Balita perlu imunisasi minggu ini',
            //   color: Colors.orange,
            //   onTap: () {},
            // ),
            // _buildAlertCard(
            //   icon: Icons.medical_services,
            //   title: '5 Ibu hamil jadwal kontrol bulan ini',
            //   color: Colors.red,
            //   onTap: () {},
            // ),
            // _buildAlertCard(
            //   icon: Icons.inventory_2,
            //   title: 'Stok vitamin A menipis',
            //   color: Colors.blue,
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }

  // --------------------- Widget Builders ---------------------

  static Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    required List<Color> gradientColors,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors.map((c) => c.withOpacity(0.1)).toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
      ),
    );
  }

  static Widget _buildAlertCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(12),
            color: color.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
