import 'package:flutter/material.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Posyandu'),
        backgroundColor: Colors.teal.shade600,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildJadwalCard(
            tanggal: '15 November 2025',
            waktu: '08:00 - 12:00 WIB',
            lokasi: 'Posyandu Melati RT 05',
            status: 'Akan Datang',
            statusColor: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildJadwalCard(
            tanggal: '15 Oktober 2025',
            waktu: '08:00 - 12:00 WIB',
            lokasi: 'Posyandu Melati RT 05',
            status: 'Selesai',
            statusColor: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildJadwalCard(
            tanggal: '15 September 2025',
            waktu: '08:00 - 12:00 WIB',
            lokasi: 'Posyandu Melati RT 05',
            status: 'Selesai',
            statusColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildJadwalCard({
    required String tanggal,
    required String waktu,
    required String lokasi,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tanggal,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                waktu,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                lokasi,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}