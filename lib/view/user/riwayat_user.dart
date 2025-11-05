import 'package:flutter/material.dart';

class RiwayatUser extends StatelessWidget {
  const RiwayatUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kunjungan'),
        backgroundColor: Colors.teal.shade600,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildRiwayatCard(
            tanggal: '15 Oktober 2025',
            jenisLayanan: 'Imunisasi & Penimbangan',
            beratBadan: '8.5 kg',
            tinggiBadan: '72 cm',
            catatan: 'Perkembangan baik, sesuai usia',
          ),
          const SizedBox(height: 12),
          _buildRiwayatCard(
            tanggal: '15 September 2025',
            jenisLayanan: 'Penimbangan',
            beratBadan: '8.2 kg',
            tinggiBadan: '70 cm',
            catatan: 'Nafsu makan baik',
          ),
          const SizedBox(height: 12),
          _buildRiwayatCard(
            tanggal: '15 Agustus 2025',
            jenisLayanan: 'Imunisasi BCG',
            beratBadan: '7.8 kg',
            tinggiBadan: '68 cm',
            catatan: 'Imunisasi berhasil',
          ),
        ],
      ),
    );
  }

  Widget _buildRiwayatCard({
    required String tanggal,
    required String jenisLayanan,
    required String beratBadan,
    required String tinggiBadan,
    required String catatan,
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: Colors.teal.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                tanggal,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            jenisLayanan,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Berat Badan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      beratBadan,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tinggi Badan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      tinggiBadan,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.note, size: 16, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    catatan,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}