import 'package:flutter/material.dart';

class PanduanGiziPage extends StatelessWidget {
  const PanduanGiziPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Panduan Gizi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.teal, Colors.teal.shade700],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Icon(
                    Icons.restaurant_menu,
                    size: 60,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Panduan Gizi Seimbang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Untuk Tumbuh Kembang Optimal',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gizi Bayi 0-6 Bulan
                  _buildGiziCard(
                    title: 'Bayi 0-6 Bulan',
                    icon: Icons.child_care,
                    color: Colors.teal.shade400,
                    items: [
                      'ASI Eksklusif adalah makanan terbaik',
                      'Berikan ASI sesering mungkin sesuai permintaan bayi',
                      'Tidak perlu air putih atau makanan lain',
                      'Posisi menyusui yang benar sangat penting',
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Gizi Bayi 6-12 Bulan
                  _buildGiziCard(
                    title: 'Bayi 6-12 Bulan',
                    icon: Icons.fastfood,
                    color: Colors.teal.shade500,
                    items: [
                      'Mulai MPASI di usia 6 bulan',
                      'Tekstur bubur kental, lalu bertahap ke makanan lumat',
                      'Berikan makanan 2-3 kali sehari',
                      'Tetap berikan ASI',
                      'Variasi makanan: karbohidrat, protein, sayur, buah',
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Gizi Balita 1-5 Tahun
                  _buildGiziCard(
                    title: 'Balita 1-5 Tahun',
                    icon: Icons.emoji_food_beverage,
                    color: Colors.teal.shade600,
                    items: [
                      'Makan 3 kali sehari dengan 2 kali selingan',
                      'Berikan makanan keluarga dengan gizi seimbang',
                      'Porsi: 1/3 - 1/2 porsi dewasa',
                      'Perbanyak sayur dan buah',
                      'Batasi gula, garam, dan makanan berminyak',
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Prinsip Gizi Seimbang
                  const Text(
                    'Prinsip Gizi Seimbang',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildPrinsipCard(
                    icon: Icons.pie_chart,
                    title: 'Isi Piringku',
                    description: '50% Sayur & Buah, 35% Karbohidrat, 15% Protein',
                  ),

                  _buildPrinsipCard(
                    icon: Icons.water_drop,
                    title: 'Minum Air Putih',
                    description: 'Minimal 6-8 gelas per hari untuk balita',
                  ),

                  _buildPrinsipCard(
                    icon: Icons.sports_soccer,
                    title: 'Aktivitas Fisik',
                    description: 'Bermain aktif minimal 3 jam sehari',
                  ),

                  _buildPrinsipCard(
                    icon: Icons.monitor_weight,
                    title: 'Pantau Berat Badan',
                    description: 'Timbang berat badan secara rutin di Posyandu',
                  ),

                  const SizedBox(height: 24),

                  // Tanda Bahaya
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Text(
                              'Tanda Bahaya Gizi Buruk',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildWarningItem('Berat badan tidak naik 2 bulan berturut-turut'),
                        _buildWarningItem('Anak tampak sangat kurus'),
                        _buildWarningItem('Bengkak pada kedua kaki'),
                        _buildWarningItem('Tidak aktif atau lemas'),
                        const SizedBox(height: 8),
                        Text(
                          '⚠️ Segera konsultasi ke tenaga kesehatan!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Call to Action
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.teal.shade400, Colors.teal.shade600],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 40,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Kunjungi Posyandu Rutin',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Untuk pemantauan tumbuh kembang anak',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGiziCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<String> items,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPrinsipCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}