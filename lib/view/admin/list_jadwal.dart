import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_ppkd/view/admin/bottom_nav.dart';
import 'package:project_ppkd/view/admin/input_jadwal.dart';

class ListJadwalPage extends StatefulWidget {
  const ListJadwalPage({Key? key}) : super(key: key);

  @override
  State<ListJadwalPage> createState() => _ListJadwalPageState();
}

class _ListJadwalPageState extends State<ListJadwalPage> {
  String _selectedFilter = 'all'; // all, upcoming, ongoing, completed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            // LIST DARI FIREBASE
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('jadwal_posyandu')
                    .orderBy('tanggal', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return _buildEmptyState();
                  }

                  // Convert data
                  final List<Map<String, dynamic>> jadwalList = snapshot.data!.docs
                      .map((doc) => {
                            'id': doc.id,
                            ...doc.data() as Map<String, dynamic>,
                          })
                      .toList();

                  // Filter
                  final filteredList = _filterList(jadwalList);

                  if (filteredList.isEmpty) return _buildEmptyState();

                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return _buildJadwalCard(filteredList[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // FILTER LIST
  // -------------------------------------------------------------
  List<Map<String, dynamic>> _filterList(List<Map<String, dynamic>> list) {
    if (_selectedFilter == 'all') return list;

    return list.where((item) {
      final status = item['status'] ?? 'upcoming';
      return status == _selectedFilter;
    }).toList();
  }

  // -------------------------------------------------------------
  // HEADER UI
  // -------------------------------------------------------------
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A6EF5), Color(0xFF6B5CE0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.white),
  onPressed: () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => BottomNav(initialIndex: 0),
      ),
      (route) => false,
    );
  },
),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jadwal Posyandu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Daftar kegiatan posyandu',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // FILTER CHIPS
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('Semua', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Mendatang', 'upcoming'),
                const SizedBox(width: 8),
                _buildFilterChip('Berlangsung', 'ongoing'),
                const SizedBox(width: 8),
                _buildFilterChip('Selesai', 'completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        setState(() => _selectedFilter = value);
      },
      backgroundColor: Colors.white.withOpacity(0.2),
      selectedColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF4A6EF5) : Colors.white,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: const Color(0xFF4A6EF5),
      side: BorderSide(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.3),
      ),
    );
  }

  // -------------------------------------------------------------
  // EMPTY STATE
  // -------------------------------------------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Belum ada jadwal',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Klik tombol "Buat Jadwal" untuk menambah',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // CARD (UI TIDAK DIUBAH)
  // -------------------------------------------------------------
  Widget _buildJadwalCard(Map<String, dynamic> jadwal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showDetailDialog(jadwal),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER ROW
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: _getJenisKegiatanColor(jadwal['jenisKegiatan']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _getJenisKegiatanEmoji(jadwal['jenisKegiatan']),
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jadwal['namaKegiatan'] ?? '',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getJenisKegiatanLabel(jadwal['jenisKegiatan']),
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusBadge(jadwal['status'] ?? 'upcoming'),
                  ],
                ),

                const SizedBox(height: 16),

                Container(height: 1, color: Colors.grey.shade200),
                const SizedBox(height: 16),

                // DATE & TIME
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                   Text(formatTanggal(jadwal['tanggal'])),
                    const SizedBox(width: 16),
                    Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Text('${jadwal['waktuMulai']} - ${jadwal['waktuSelesai']}'),
                  ],
                ),

                const SizedBox(height: 8),

                // LOCATION
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey.shade600),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        jadwal['lokasi'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // KUOTA
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Kuota Peserta', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                              Text(
                                '${jadwal['pesertaTerdaftar'] ?? 0}/${jadwal['kuota']}',
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF4A6EF5)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: (jadwal['pesertaTerdaftar'] ?? 0) / jadwal['kuota'],
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation(
                                _getProgressColor((jadwal['pesertaTerdaftar'] ?? 0) / jadwal['kuota']),
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ACTION BUTTONS
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showDetailDialog(jadwal),
                        icon: const Icon(Icons.info_outline, size: 18),
                        label: const Text('Detail'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF4A6EF5),
                          side: const BorderSide(color: Color(0xFF4A6EF5)),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuatJadwalPosyanduPage(
                              isEdit: true,
                              data: jadwal,
                            ),
                          ),
                        );
                        },
                        icon: const Icon(Icons.edit, size: 18),
                        label: const Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A6EF5),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    IconButton(
                      onPressed: () => _confirmDelete(jadwal),
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // STATUS BADGE
  // -------------------------------------------------------------
  Widget _buildStatusBadge(String status) {
    Color bg, txt;
    String label;

    switch (status) {
      case 'upcoming':
        bg = Colors.blue.shade50;
        txt = Colors.blue.shade700;
        label = 'Mendatang';
        break;
      case 'ongoing':
        bg = Colors.green.shade50;
        txt = Colors.green.shade700;
        label = 'Berlangsung';
        break;
      case 'completed':
        bg = Colors.grey.shade200;
        txt = Colors.grey.shade700;
        label = 'Selesai';
        break;
      default:
        bg = Colors.grey.shade200;
        txt = Colors.grey.shade700;
        label = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: txt)),
    );
  }

  // -------------------------------------------------------------
  // HELPER FUNCTIONS
  // -------------------------------------------------------------
  Color _getJenisKegiatanColor(String jenis) {
    switch (jenis) {
      case 'balita': return Colors.orange;
      case 'ibu_hamil': return Colors.pink;
      case 'gabungan': return Colors.purple;
      case 'imunisasi': return Colors.blue;
      default: return Colors.grey;
    }
  }

  String formatTanggal(String tanggal) {
  try {
    // split tanggal
    final parts = tanggal.split("/"); // [dd, mm, yyyy]
    if (parts.length != 3) return tanggal;

    final day = int.tryParse(parts[0]) ?? 0;
    final month = int.tryParse(parts[1]) ?? 0;
    final year = int.tryParse(parts[2]) ?? 0;

    // nama bulan
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

    return "$day ${namaBulan[month]} $year";
  } catch (e) {
    return tanggal;
  }
}


  String _getJenisKegiatanEmoji(String jenis) {
    switch (jenis) {
      case 'balita': return '👶';
      case 'ibu_hamil': return '🤰';
      case 'gabungan': return '👨‍👩‍👧';
      case 'imunisasi': return '💉';
      default: return '📋';
    }
  }

  String _getJenisKegiatanLabel(String jenis) {
    switch (jenis) {
      case 'balita': return 'Posyandu Balita';
      case 'ibu_hamil': return 'Posyandu Ibu Hamil';
      case 'gabungan': return 'Posyandu Gabungan';
      case 'imunisasi': return 'Imunisasi Khusus';
      default: return 'Unknown';
    }
  }

  Color _getProgressColor(double progress) {
    if (progress >= 0.9) return Colors.red;
    if (progress >= 0.7) return Colors.orange;
    return Colors.green;
  }

void _showDetailDialog(Map<String, dynamic> jadwal) { showDialog( context: context, builder: (BuildContext context) { return Dialog( shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20), ), child: Container( constraints: const BoxConstraints(maxHeight: 600), child: Column( mainAxisSize: MainAxisSize.min, children: [  Container( padding: const EdgeInsets.all(20), decoration: BoxDecoration( gradient: const LinearGradient( colors: [Color(0xFF4A6EF5), Color(0xFF6B5CE0)], begin: Alignment.topLeft, end: Alignment.bottomRight, ), borderRadius: const BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20), ), ), child: Row( children: [ Text( _getJenisKegiatanEmoji(jadwal['jenisKegiatan']), style: const TextStyle(fontSize: 32), ), const SizedBox(width: 12), Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ const Text( 'Detail Jadwal', style: TextStyle( color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, ), ), const SizedBox(height: 4), Text( _getJenisKegiatanLabel(jadwal['jenisKegiatan']), style: const TextStyle( color: Colors.white70, fontSize: 13, ), ), ], ), ), IconButton( onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close, color: Colors.white), ), ], ), ),  Flexible( child: SingleChildScrollView( padding: const EdgeInsets.all(20), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text( jadwal['namaKegiatan'], style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold, ), ), const SizedBox(height: 20), _buildDetailRow(Icons.calendar_today, 'Tanggal', jadwal['tanggal']), _buildDetailRow(Icons.access_time, 'Waktu', '${jadwal['waktuMulai']} - ${jadwal['waktuSelesai']}'), _buildDetailRow(Icons.location_on, 'Lokasi', jadwal['lokasi']), _buildDetailRow(Icons.people, 'Kuota', '${jadwal['pesertaTerdaftar']}/${jadwal['kuota']} peserta'), const SizedBox(height: 20), const Text( 'Deskripsi', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, ), ), const SizedBox(height: 8), Text( jadwal['deskripsi'], style: TextStyle( fontSize: 14, color: Colors.grey.shade700, height: 1.5, ), ), const SizedBox(height: 20), const Text( 'Agenda Kegiatan', style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold, ), ), const SizedBox(height: 12), ...List.generate( (jadwal['agenda'] as List).length, (index) => Padding( padding: const EdgeInsets.only(bottom: 8), child: Row( crossAxisAlignment: CrossAxisAlignment.start, children: [ Container( width: 24, height: 24, margin: const EdgeInsets.only(top: 2), decoration: BoxDecoration( color: const Color(0xFF4A6EF5), borderRadius: BorderRadius.circular(4), ), child: Center( child: Text( '${index + 1}', style: const TextStyle( color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold, ), ), ), ), const SizedBox(width: 12), Expanded( child: Text( jadwal['agenda'][index], style: TextStyle( fontSize: 14, color: Colors.grey.shade700, height: 1.5, ), ), ), ], ), ), ), ], ), ), ), ], ), ), ); }, ); } Widget _buildDetailRow(IconData icon, String label, String value) { return Padding( padding: const EdgeInsets.only(bottom: 12), child: Row( crossAxisAlignment: CrossAxisAlignment.start, children: [ Icon(icon, size: 20, color: const Color(0xFF4A6EF5)), const SizedBox(width: 12), Expanded( child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text( label, style: TextStyle( fontSize: 12, color: Colors.grey.shade600, ), ), const SizedBox(height: 2), Text( value, style: const TextStyle( fontSize: 14, fontWeight: FontWeight.w600, ), ), ], ), ), ], ), ); }

 void _confirmDelete(Map<String, dynamic> jadwal) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 28),
            const SizedBox(width: 12),
            const Text(
              'Hapus Jadwal',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Apakah Anda yakin ingin menghapus jadwal "${jadwal['namaKegiatan']}"? Tindakan ini tidak dapat dibatalkan.',
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          // Tombol Batal
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Batal',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Tombol Hapus
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              // Hapus data
              await FirebaseFirestore.instance
                  .collection('jadwal_posyandu')
                  .doc(jadwal['id'])
                  .delete();

              // Tutup dialog
              Navigator.pop(context);

              // Tampilkan SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Jadwal berhasil dihapus'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Hapus',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    },
  );
}
}