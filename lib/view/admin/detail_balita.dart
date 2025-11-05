import 'package:flutter/material.dart';
import 'package:project_ppkd/database/db_helper.dart';
import 'package:project_ppkd/model/anak_model.dart';
import 'package:project_ppkd/view/admin/form_balita.dart';

class DetailBalitaPage extends StatelessWidget {
  final Anak anak;
  final int anakId;
  final int userId;

  const DetailBalitaPage({
    Key? key,
    required this.anak,
    required this.anakId,
    required this.userId,
  }) : super(key: key);

  Future<void> _hapusData(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus data ${anak.nama}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      try {
        await DbHelper.deleteAnak(anakId);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil dihapus')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menghapus: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Balita'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormBalitaPage(
                    userId: userId,
                    anak: anak,
                    anakId: anakId,
                  ),
                ),
              );
              if (result == true && context.mounted) {
                Navigator.pop(context, true);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _hapusData(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: anak.gradientColors),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    anak.isLakiLaki ? Icons.boy : Icons.girl,
                    size: 50,
                    color: anak.isLakiLaki ? Colors.blue : Colors.pink,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  anak.nama,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  anak.usiaString,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Data Antropometri
          _buildInfoCard(
            'Data Antropometri',
            Icons.straighten,
            [
              _buildInfoRow('Berat Badan', '${anak.beratBadan} kg'),
              _buildInfoRow('Tinggi Badan', '${anak.tinggiBadan} cm'),
              _buildInfoRow('Lingkar Kepala', '${anak.lingkarKepala} cm'),
              _buildInfoRow('IMT', anak.imt.toStringAsFixed(1)),
            ],
          ),
          const SizedBox(height: 12),

          // Status Kesehatan
          _buildInfoCard(
            'Status Kesehatan',
            Icons.health_and_safety,
            [
              _buildStatusRow('Status Gizi', anak.statusGizi, anak.statusGiziColor),
              _buildInfoRow('Status Stunting', anak.statusStunting),
            ],
          ),
          const SizedBox(height: 12),

          // Data Pribadi
          _buildInfoCard(
            'Data Pribadi',
            Icons.person,
            [
              _buildInfoRow('Jenis Kelamin', anak.jenisKelamin),
              _buildInfoRow('Golongan Darah', anak.golonganDarah),
              _buildInfoRow(
                'Tanggal Lahir',
                _formatDate(anak.tanggalLahir),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Riwayat
          _buildInfoCard(
            'Riwayat',
            Icons.history,
            [
              _buildInfoRow('Imunisasi Terakhir', anak.imunisasiTerakhir),
              _buildInfoRow(
                'Kunjungan Terakhir',
                _formatDate(anak.kunjunganTerakhir),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Rekomendasi
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.lightbulb, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        'Rekomendasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    anak.rekomendasiGizi,
                    style: const TextStyle(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color),
            ),
            child: Text(
              value.split('(').first.trim(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      final months = [
        'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return isoDate;
    }
  }
}