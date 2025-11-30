import 'package:flutter/material.dart';
import 'package:project_ppkd/model/jadwal_firebase.dart';
import 'package:project_ppkd/service/firebase_jadwal.dart';

class BuatJadwalPosyanduPage extends StatefulWidget {
  final bool isEdit;
  final Map<String, dynamic>? data; // DATA UNTUK EDIT

  const BuatJadwalPosyanduPage({
    Key? key,
    this.isEdit = false,
    this.data,
  }) : super(key: key);

  @override
  State<BuatJadwalPosyanduPage> createState() => _BuatJadwalPosyanduPageState();
}

class _BuatJadwalPosyanduPageState extends State<BuatJadwalPosyanduPage> {
  final TextEditingController _namaKegiatanController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();
  final TextEditingController _waktuMulaiController = TextEditingController();
  final TextEditingController _waktuSelesaiController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _kuotaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _agendaController = TextEditingController();

  String _jenisKegiatan = '';
  List<String> _agendaList = [];

  // ---------------------------------------------------------
  // INIT STATE (ISI DATA JIKA EDIT)
  // ---------------------------------------------------------
  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.data != null) {
      final d = widget.data!;
      _namaKegiatanController.text = d['namaKegiatan'] ?? '';
      _jenisKegiatan = d['jenisKegiatan'] ?? '';
      _tanggalController.text = d['tanggal'] ?? '';
      _waktuMulaiController.text = d['waktuMulai'] ?? '';
      _waktuSelesaiController.text = d['waktuSelesai'] ?? '';
      _lokasiController.text = d['lokasi'] ?? '';
      _kuotaController.text = (d['kuota'] ?? '').toString();
      _deskripsiController.text = d['deskripsi'] ?? '';
      _agendaList = List<String>.from(d['agenda'] ?? []);
    }
  }

  @override
  void dispose() {
    _namaKegiatanController.dispose();
    _tanggalController.dispose();
    _waktuMulaiController.dispose();
    _waktuSelesaiController.dispose();
    _lokasiController.dispose();
    _kuotaController.dispose();
    _deskripsiController.dispose();
    _agendaController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------
  // VALIDASI FORM
  // ---------------------------------------------------------
  void _validateAndSave() {
    if (_namaKegiatanController.text.trim().isEmpty) {
      _showErrorDialog('Nama kegiatan harus diisi');
      return;
    }

    if (_jenisKegiatan.isEmpty) {
      _showErrorDialog('Jenis kegiatan harus dipilih');
      return;
    }

    if (_tanggalController.text.trim().isEmpty) {
      _showErrorDialog('Tanggal harus diisi');
      return;
    }

    if (_waktuMulaiController.text.trim().isEmpty) {
      _showErrorDialog('Waktu mulai harus diisi');
      return;
    }

    if (_waktuSelesaiController.text.trim().isEmpty) {
      _showErrorDialog('Waktu selesai harus diisi');
      return;
    }

    if (_lokasiController.text.trim().isEmpty) {
      _showErrorDialog('Lokasi harus diisi');
      return;
    }

    if (_kuotaController.text.trim().isEmpty) {
      _showErrorDialog('Kuota peserta harus diisi');
      return;
    }

    if (_deskripsiController.text.trim().isEmpty) {
      _showErrorDialog('Deskripsi harus diisi');
      return;
    }

    if (_agendaList.isEmpty) {
      _showErrorDialog('Agenda kegiatan minimal harus ada 1');
      return;
    }

    _saveSchedule();
  }

  // ---------------------------------------------------------
  // SIMPAN DATA (ADD / UPDATE)
  // ---------------------------------------------------------
  Future<void> _saveSchedule() async {
    final model = JadwalPosyanduModel(
      namaKegiatan: _namaKegiatanController.text.trim(),
      jenisKegiatan: _jenisKegiatan,
      tanggal: _tanggalController.text.trim(),
      waktuMulai: _waktuMulaiController.text.trim(),
      waktuSelesai: _waktuSelesaiController.text.trim(),
      lokasi: _lokasiController.text.trim(),
      kuota: int.tryParse(_kuotaController.text.trim()),
      deskripsi: _deskripsiController.text.trim(),
      agenda: _agendaList,
    );

    bool success = false;

    if (widget.isEdit) {
  // isi ID dokumen
  model.id = widget.data!['id'];

  // update
  success = await FirebaseJadwalService.updateJadwal(model);

} else {
  // tambah
  success = await FirebaseJadwalService.tambahJadwal(model);
}


    if (!success) {
      _showErrorDialog("Gagal menyimpan jadwal. Silakan coba lagi.");
      return;
    }

    // NOTIFIKASI BERHASIL
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green.shade600, size: 28),
              const SizedBox(width: 12),
              Text(
                widget.isEdit ? 'Berhasil Mengupdate' : 'Berhasil',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            widget.isEdit
                ? 'Jadwal posyandu berhasil diperbarui!'
                : 'Jadwal posyandu berhasil disimpan!',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                Navigator.pop(context); // kembali ke list
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4A6EF5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'OK',
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

  // ---------------------------------------------------------
  // ERROR DIALOG
  // ---------------------------------------------------------
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: Colors.orange.shade700, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Perhatian',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(message, style: const TextStyle(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF4A6EF5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------------------------------------------------
  // SELECTORS & AGENDA
  // ---------------------------------------------------------
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text =
            "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  void _addAgenda() {
    if (_agendaController.text.isNotEmpty) {
      setState(() {
        _agendaList.add(_agendaController.text);
        _agendaController.clear();
      });
    }
  }

  // ---------------------------------------------------------
  // UI (TIDAK DIUBAH SAMA SEKALI)
  // ---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildForm()),
          ],
        ),
      ),
      floatingActionButton: _buildSaveButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

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
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Text(
            widget.isEdit ? 'Edit Jadwal Posyandu' : 'Buat Jadwal Posyandu',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _validateAndSave,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A6EF5),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              widget.isEdit ? "Simpan Perubahan" : "Simpan Jadwal Posyandu",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildSectionCard(
            icon: Icons.calendar_today,
            title: "Informasi Dasar",
            children: [
              const SizedBox(height: 8),
              _buildTextField(controller: _namaKegiatanController, hint: "Nama kegiatan"),
              const SizedBox(height: 16),
              _buildJenisKegiatanOptions(),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            icon: Icons.access_time,
            title: "Waktu & Tempat",
            children: [
              _buildDateField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTimeField(_waktuMulaiController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTimeField(_waktuSelesaiController)),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(controller: _lokasiController, hint: "Lokasi"),
              const SizedBox(height: 16),
              _buildTextField(controller: _kuotaController, hint: "Kuota Peserta", keyboardType: TextInputType.number),
            ],
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            icon: Icons.description,
            title: "Detail Kegiatan",
            children: [
              _buildTextField(controller: _deskripsiController, hint: "Deskripsi kegiatan", maxLines: 3),
              const SizedBox(height: 16),
              _buildAgendaField(),
              const SizedBox(height: 12),
              ..._agendaList.asMap().entries.map((e) => _buildAgendaItem(e.key, e.value)),
            ],
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // Semua UI helper di bawah *tidak diubah* (dipertahankan)
  // ---------------------------------------------------------
  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
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
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4A6EF5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF4A6EF5)),
              ),
              const SizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 18),
            const SizedBox(width: 12),
            Text(
              _tanggalController.text.isNotEmpty
                  ? _tanggalController.text
                  : "Pilih Tanggal",
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimeField(TextEditingController controller) {
    return InkWell(
      onTap: () => _selectTime(context, controller),
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: 18),
            const SizedBox(width: 12),
            Text(
              controller.text.isEmpty ? "--:--" : controller.text,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildJenisKegiatanOptions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _jenisCard("👶", "balita", "Posyandu Balita"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _jenisCard("🤰", "ibu_hamil", "Posyandu Ibu Hamil"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _jenisCard("👨‍👩‍👧", "gabungan", "Posyandu Gabungan"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _jenisCard("💉", "imunisasi", "Imunisasi Khusus"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _jenisCard(String emoji, String value, String label) {
    final isSelected = _jenisKegiatan == value;

    return InkWell(
      onTap: () => setState(() => _jenisKegiatan = value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4A6EF5) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? const Color(0xFF4A6EF5).withOpacity(0.1)
              : Colors.white,
        ),
        child: Row(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF4A6EF5) : Colors.black,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgendaField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _agendaController,
            onSubmitted: (value) => _addAgenda(),
            decoration: InputDecoration(
              hintText: "Tambah agenda",
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _addAgenda,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4A6EF5),
          ),
          child: const Text(
            "Tambah",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildAgendaItem(int index, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: const Color(0xFF4A6EF5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            IconButton(
              onPressed: () => setState(() => _agendaList.removeAt(index)),
              icon: const Icon(Icons.close, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
