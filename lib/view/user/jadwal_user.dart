import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text(
          'Jadwal Posyandu',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal.shade600,
        elevation: 0,
         iconTheme: const IconThemeData(
        color: Colors.white,
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jadwal_posyandu')
            .orderBy('tanggal', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada jadwal posyandu",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          final List<Map<String, dynamic>> listJadwal =
              snapshot.data!.docs.map((doc) {
            return {
              'id': doc.id,
              ...doc.data() as Map<String, dynamic>,
            };
          }).toList();

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: listJadwal.length,
            itemBuilder: (context, index) {
              final jd = listJadwal[index];

              return Column(
                children: [
                  _buildJadwalCard(jd),
                  const SizedBox(height: 16),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildJadwalCard(Map<String, dynamic> jd) {
    final tanggal = _formatTanggal(jd['tanggal']);
    final waktu = "${jd['waktuMulai']} - ${jd['waktuSelesai']}";
    final lokasi = jd['lokasi'];
    final status = _statusLabel(jd['status']);
    final statusColor = _statusColor(jd['status']);
    final namaKegiatan = jd['namaKegiatan'] ?? "-";
    final jenisKegiatan = _jenisLabel(jd['jenisKegiatan']);
    final kuota = jd['kuota']?.toString() ?? "-";
    final deskripsi = jd['deskripsi'] ?? "-";
    final List agenda = jd['agenda'] ?? [];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tanggal,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // NAMA KEGIATAN
          Text(
            namaKegiatan,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          // JENIS
          Text(
            jenisKegiatan,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.teal,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          // WAKTU
          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              const SizedBox(width: 8),
              Text(waktu, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),

          const SizedBox(height: 6),

          // LOKASI
          Row(
            children: [
              const Icon(Icons.location_on, size: 18),
              const SizedBox(width: 8),
              Text(lokasi, style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),

          const SizedBox(height: 6),

          // KUOTA
          Row(
            children: [
              const Icon(Icons.people, size: 18),
              const SizedBox(width: 8),
              Text("Kuota: $kuota peserta",
                  style: TextStyle(color: Colors.grey.shade700)),
            ],
          ),

          const SizedBox(height: 16),

          // DESKRIPSI
          const Text(
            "Deskripsi",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(deskripsi),

          const SizedBox(height: 16),

          // AGENDA
          const Text(
            "Agenda Kegiatan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          ...agenda.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "${e.key + 1}",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      e.value,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // ============================
  // FORMAT TANGGAL
  // ============================
  String _formatTanggal(String tanggal) {
    try {
      final part = tanggal.split("/");
      final d = int.parse(part[0]);
      final m = int.parse(part[1]);
      final y = int.parse(part[2]);

      const namaBulan = {
        1: "Januari",
        2: "Februari",
        3: "Maret",
        4: "April",
        5: "Mei",
        6: "Juni",
        7: "Juli",
        8: "Agustus",
        9: "September",
        10: "Oktober",
        11: "November",
        12: "Desember",
      };

      return "$d ${namaBulan[m]} $y";
    } catch (_) {
      return tanggal;
    }
  }

  // ============================
  // STATUS LABEL
  // ============================
  String _statusLabel(String? status) {
    switch (status) {
      case "upcoming":
        return "Akan Datang";
      case "ongoing":
        return "Berlangsung";
      case "completed":
        return "Selesai";
      default:
        return "Tidak Diketahui";
    }
  }

  // ============================
  // STATUS WARNA
  // ============================
  Color _statusColor(String? status) {
    switch (status) {
      case "upcoming":
        return Colors.orange;
      case "ongoing":
        return Colors.blue;
      case "completed":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  // ============================
  // JENIS KEGIATAN LABEL
  // ============================
  String _jenisLabel(String? jenis) {
    switch (jenis) {
      case "balita":
        return "👶 Posyandu Balita";
      case "ibu_hamil":
        return "🤰 Posyandu Ibu Hamil";
      case "gabungan":
        return "👨‍👩‍👧 Posyandu Gabungan";
      case "imunisasi":
        return "💉 Imunisasi Khusus";
      default:
        return "-";
    }
  }
}
