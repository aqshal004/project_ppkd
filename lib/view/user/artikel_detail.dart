import 'package:flutter/material.dart';
import 'package:project_ppkd/model/artikel_model.dart';


class ArtikelDetailPage extends StatefulWidget {
  final Article article;

  const ArtikelDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  State<ArtikelDetailPage> createState() => _ArtikelDetailPageState();
}

class _ArtikelDetailPageState extends State<ArtikelDetailPage> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.teal,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.teal),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.teal,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isBookmarked
                            ? 'Artikel disimpan'
                            : 'Artikel dihapus dari bookmark',
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.teal,
                    ),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.teal.shade400, Colors.teal.shade700],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.article,
                    size: 100,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      widget.article.category,
                      style: TextStyle(
                        color: Colors.teal.shade700,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.teal,
                        child: Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tim Kesehatan Posyandu',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.article.date,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.access_time, size: 16, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        widget.article.readTime,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 24),
                  const Text(
                    'Pemberian Makanan Pendamping ASI (MPASI) adalah fase penting dalam tumbuh kembang bayi. Pada usia 6 bulan, sistem pencernaan bayi sudah mulai siap menerima makanan selain ASI.\n\nBerikut adalah panduan lengkap untuk memulai MPASI pertama:\n\n1. Waktu yang Tepat\nMulai MPASI saat bayi berusia 6 bulan. Tanda-tanda bayi siap MPASI meliputi:\n- Mampu duduk dengan bantuan\n- Menunjukkan ketertarikan pada makanan\n- Refleks menjulurkan lidah sudah berkurang\n\n2. Tekstur yang Sesuai\nMulai dengan tekstur bubur kental (puree) yang halus. Secara bertahap tingkatkan teksturnya seiring perkembangan bayi.\n\n3. Menu MPASI Pertama\n- Mulai dengan menu tunggal (single ingredient)\n- Berikan selama 3-5 hari untuk mengamati reaksi alergi\n- Pilihan menu: bubur beras, pisang, alpukat, ubi\n\n4. Porsi dan Frekuensi\n- Awal: 2-3 sendok makan, 1-2 kali sehari\n- Tingkatkan bertahap hingga 125ml, 2-3 kali sehari\n- Tetap berikan ASI sesuai permintaan\n\n5. Hal yang Harus Dihindari\n- Gula dan garam tambahan\n- Madu (risiko botulisme)\n- Makanan keras yang berisiko tersedak\n- Susu sapi sebelum usia 1 tahun\n\n6. Tips Sukses MPASI\n- Buat suasana makan yang menyenangkan\n- Jangan memaksa jika bayi menolak\n- Konsisten dengan jadwal makan\n- Perkenalkan berbagai rasa dan tekstur\n\nIngat, setiap bayi berkembang dengan kecepatannya sendiri. Konsultasikan dengan tenaga kesehatan di Posyandu untuk panduan yang lebih personal.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.8,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.teal.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.teal.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Konsultasikan kondisi bayi Anda dengan tenaga kesehatan di Posyandu terdekat',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.teal.shade900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}