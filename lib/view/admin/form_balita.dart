import 'package:flutter/material.dart';
import 'package:project_ppkd/database/db_helper.dart';
import 'package:project_ppkd/model/anak_model.dart';

class FormBalitaPage extends StatefulWidget {
  final int userId;
  final Anak? anak;
  final int? anakId;

  const FormBalitaPage({
    Key? key,
    required this.userId,
    this.anak,
    this.anakId,
  }) : super(key: key);

  @override
  State<FormBalitaPage> createState() => _FormBalitaPageState();
}

class _FormBalitaPageState extends State<FormBalitaPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _beratController = TextEditingController();
  final _tinggiController = TextEditingController();
  final _lingkarController = TextEditingController();
  final _imunisasiController = TextEditingController();
  
  DateTime? _tanggalLahir;
  String _jenisKelamin = 'Laki-laki';
  String _golonganDarah = 'A';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.anak != null) {
      _namaController.text = widget.anak!.nama;
      _beratController.text = widget.anak!.beratBadan.toString();
      _tinggiController.text = widget.anak!.tinggiBadan.toString();
      _lingkarController.text = widget.anak!.lingkarKepala.toString();
      _imunisasiController.text = widget.anak!.imunisasiTerakhir;
      _tanggalLahir = DateTime.parse(widget.anak!.tanggalLahir);
      _jenisKelamin = widget.anak!.jenisKelamin;
      _golonganDarah = widget.anak!.golonganDarah;
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _beratController.dispose();
    _tinggiController.dispose();
    _lingkarController.dispose();
    _imunisasiController.dispose();
    super.dispose();
  }

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() => _tanggalLahir = picked);
    }
  }

  Future<void> _simpan() async {
    if (!_formKey.currentState!.validate() || _tanggalLahir == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua data')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final anak = Anak(
        nama: _namaController.text,
        tanggalLahir: _tanggalLahir!.toIso8601String(),
        jenisKelamin: _jenisKelamin,
        beratBadan: double.parse(_beratController.text),
        tinggiBadan: double.parse(_tinggiController.text),
        lingkarKepala: double.parse(_lingkarController.text),
        golonganDarah: _golonganDarah,
        imunisasiTerakhir: _imunisasiController.text,
        kunjunganTerakhir: DateTime.now().toIso8601String(),
      );

      if (widget.anak == null) {
        await DbHelper.createAnak(anak, widget.userId);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil ditambahkan')),
          );
        }
      } else {
        await DbHelper.updateAnak(anak, widget.anakId!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil diupdate')),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.anak == null ? 'Tambah Balita' : 'Edit Balita'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Nama
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) => v!.isEmpty ? 'Nama wajib diisi' : null,
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 16),

            // Tanggal Lahir
            InkWell(
              onTap: _pilihTanggal,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _tanggalLahir == null
                      ? 'Pilih tanggal'
                      : '${_tanggalLahir!.day}/${_tanggalLahir!.month}/${_tanggalLahir!.year}',
                  style: TextStyle(
                    color: _tanggalLahir == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Jenis Kelamin
            DropdownButtonFormField<String>(
              value: _jenisKelamin,
              decoration: const InputDecoration(
                labelText: 'Jenis Kelamin',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.wc),
              ),
              items: ['Laki-laki', 'Perempuan']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _jenisKelamin = v!),
            ),
            const SizedBox(height: 16),

            // Berat & Tinggi
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _beratController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Berat (kg)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.monitor_weight),
                    ),
                    validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _tinggiController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Tinggi (cm)',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.height),
                    ),
                    validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Lingkar Kepala
            TextFormField(
              controller: _lingkarController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Lingkar Kepala (cm)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.circle_outlined),
              ),
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
            ),
            const SizedBox(height: 16),

            // Golongan Darah
            DropdownButtonFormField<String>(
              value: _golonganDarah,
              decoration: const InputDecoration(
                labelText: 'Golongan Darah',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.bloodtype),
              ),
              items: ['A', 'B', 'AB', 'O']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _golonganDarah = v!),
            ),
            const SizedBox(height: 16),

            // Imunisasi
            TextFormField(
              controller: _imunisasiController,
              decoration: const InputDecoration(
                labelText: 'Imunisasi Terakhir',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.vaccines),
                hintText: 'Contoh: BCG, Hepatitis B',
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            ElevatedButton(
              onPressed: _isLoading ? null : _simpan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      widget.anak == null ? 'Simpan' : 'Update',
                      style: const TextStyle(fontSize: 16),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}