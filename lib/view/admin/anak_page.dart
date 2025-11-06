import 'package:flutter/material.dart';
import 'package:project_ppkd/database/db_helper.dart';
import 'package:project_ppkd/model/anak_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class AnakPage extends StatefulWidget {
  const AnakPage({super.key});

  @override
  State<AnakPage> createState() => _AnakPageState();
}

class _AnakPageState extends State<AnakPage> {
  late Future<List<Anak>> _anakFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      _anakFuture = DbHelper.getAllAnak();
    });
  }

  Future<int?> _getUserIdFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId'); // disimpan saat login
  }

 void _showForm({Anak? anak}) {
  final namaController = TextEditingController(text: anak?.nama ?? '');
  final tanggalLahirController = TextEditingController(text: anak?.tanggalLahir ?? '');
  String? selectedJenisKelamin = anak?.jenisKelamin; // dropdown value
  final beratController = TextEditingController(text: anak?.beratBadan.toString() ?? '');
  final tinggiController = TextEditingController(text: anak?.tinggiBadan.toString() ?? '');
  final lingkarController = TextEditingController(text: anak?.lingkarKepala.toString() ?? '');
  final golonganController = TextEditingController(text: anak?.golonganDarah ?? '');
  final imunisasiController = TextEditingController(text: anak?.imunisasiTerakhir ?? '');
  final kunjunganController = TextEditingController(text: anak?.kunjunganTerakhir ?? '');

  showDialog(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          title: Text(anak == null ? 'Tambah Data Anak' : 'Edit Data Anak'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(namaController, 'Nama Anak'),

                // === Tanggal Lahir (pakai DatePicker) ===
                GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: anak?.tanggalLahir != null
                          ? DateTime.tryParse(anak!.tanggalLahir) ?? DateTime.now()
                          : DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      setStateDialog(() {
                        tanggalLahirController.text = formattedDate;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: _buildTextField(
                      tanggalLahirController,
                      'Tanggal Lahir',
                    ),
                  ),
                ),

                // === Dropdown Jenis Kelamin ===
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DropdownButtonFormField<String>(
                    value: selectedJenisKelamin,
                    decoration: const InputDecoration(
                      labelText: 'Jenis Kelamin',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                      DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                    ],
                    onChanged: (value) {
                      setStateDialog(() {
                        selectedJenisKelamin = value;
                      });
                    },
                  ),
                ),

                _buildTextField(beratController, 'Berat Badan (kg)', keyboard: TextInputType.number),
                _buildTextField(tinggiController, 'Tinggi Badan (cm)', keyboard: TextInputType.number),
                _buildTextField(lingkarController, 'Lingkar Kepala (cm)', keyboard: TextInputType.number),
                _buildTextField(golonganController, 'Golongan Darah'),
                _buildTextField(imunisasiController, 'Imunisasi Terakhir'),
                _buildTextField(kunjunganController, 'Kunjungan Terakhir'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final data = Anak(
                  id: anak?.id,
                  nama: namaController.text,
                  tanggalLahir: tanggalLahirController.text,
                  jenisKelamin: selectedJenisKelamin ?? '',
                  beratBadan: double.tryParse(beratController.text) ?? 0,
                  tinggiBadan: double.tryParse(tinggiController.text) ?? 0,
                  lingkarKepala: double.tryParse(lingkarController.text) ?? 0,
                  golonganDarah: golonganController.text,
                  imunisasiTerakhir: imunisasiController.text,
                  kunjunganTerakhir: kunjunganController.text,
                );

                if (anak == null) {
                  final userId = await _getUserIdFromPrefs() ?? 1;
                  await DbHelper.createAnak(data, userId);
                } else {
                  await DbHelper.updateAnak(data, anak.id!);
                }

                if (mounted) {
                  Navigator.pop(context);
                  _refreshData();
                }
              },
              child: Text(anak == null ? 'Simpan' : 'Update'),
            ),
          ],
        );
      },
    ),
  );
}


  Widget _buildTextField(TextEditingController c, String label,
      {TextInputType keyboard = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: c,
        keyboardType: keyboard,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _delete(int id) async {
    await DbHelper.deleteAnak(id);
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Anak'),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Anak>>(
        future: _anakFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data anak.'));
          }

          final anakList = snapshot.data!;
          return ListView.builder(
            itemCount: anakList.length,
            itemBuilder: (context, index) {
              final a = anakList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(a.nama),
                  subtitle: Text(
                    'Usia: ${a.usiaString}\n'
                      'Jenis Kelamin: ${a.jenisKelamin == 'L' ? 'Laki-laki' : 'Perempuan'}\n'
                    'BB: ${a.beratBadan} kg | TB: ${a.tinggiBadan} cm\n'
                    'Status Gizi: ${a.statusGizi}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => _showForm(anak: a),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _delete(a.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
