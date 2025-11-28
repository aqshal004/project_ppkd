import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_ppkd/model/anak_firebase.dart';
import 'package:project_ppkd/service/firebase_anak.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnakPage extends StatefulWidget {
  const AnakPage({super.key});

  @override
  State<AnakPage> createState() => _AnakPageState();
}

class _AnakPageState extends State<AnakPage> {
  String? currentUid;

  @override
void initState() {
  super.initState();
  currentUid = FirebaseAuth.instance.currentUser?.uid;
  print("UID AnakPage: $currentUid");
}


  // ==================================================
  // FORM TAMBAH / EDIT
  // ==================================================
  void _showForm({AnakFirebase? anak}) {
    final namaController = TextEditingController(text: anak?.nama ?? '');
    final tanggalLahirController = TextEditingController(text: anak?.tanggalLahir ?? '');
    String? selectedJenisKelamin = anak?.jenisKelamin;
    final beratController = TextEditingController(text: anak?.beratBadan.toString() ?? '');
    final tinggiController = TextEditingController(text: anak?.tinggiBadan.toString() ?? '');
    final lingkarController = TextEditingController(text: anak?.lingkarKepala.toString() ?? '');
    final golController = TextEditingController(text: anak?.golonganDarah ?? '');
    final imunController = TextEditingController(text: anak?.imunisasiTerakhir ?? '');
    final kunjunganController = TextEditingController(text: anak?.kunjunganTerakhir ?? '');

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(anak == null ? "Tambah Data Anak" : "Edit Data Anak"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(namaController, 'Nama Anak'),
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: anak?.tanggalLahir != null
                            ? DateTime.tryParse(anak!.tanggalLahir) ?? DateTime.now()
                            : DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (picked != null) {
                        tanggalLahirController.text =
                            DateFormat('yyyy-MM-dd').format(picked);
                        setStateDialog(() {});
                      }
                    },
                    child: AbsorbPointer(
                      child: _buildTextField(tanggalLahirController, 'Tanggal Lahir'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: DropdownButtonFormField<String>(
                      value: selectedJenisKelamin,
                      decoration: const InputDecoration(
                        labelText: 'Jenis Kelamin',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                            value: 'Laki-laki', child: Text('Laki-laki')),
                        DropdownMenuItem(
                            value: 'Perempuan', child: Text('Perempuan')),
                      ],
                      onChanged: (value) {
                        setStateDialog(() => selectedJenisKelamin = value);
                      },
                    ),
                  ),
                  _buildTextField(beratController, 'Berat Badan (kg)', keyboard: TextInputType.number),
                  _buildTextField(tinggiController, 'Tinggi Badan (cm)', keyboard: TextInputType.number),
                  _buildTextField(lingkarController, 'Lingkar Kepala (cm)', keyboard: TextInputType.number),
                  _buildTextField(golController, 'Golongan Darah'),
                  _buildTextField(imunController, 'Imunisasi Terakhir'),
                  _buildTextField(kunjunganController, 'Kunjungan Terakhir'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Batal"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (currentUid == null) return;

                  final uid = FirebaseAuth.instance.currentUser?.uid;

                if (uid == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gagal menyimpan: User tidak ditemukan")),
                  );
                  return;
                }

                final data = AnakFirebase(
                  id: anak?.id,
                  userId: uid,
                  nama: namaController.text,
                  tanggalLahir: tanggalLahirController.text,
                  jenisKelamin: selectedJenisKelamin ?? 'Laki-laki',
                  beratBadan: double.tryParse(beratController.text) ?? 0,
                  tinggiBadan: double.tryParse(tinggiController.text) ?? 0,
                  lingkarKepala: double.tryParse(lingkarController.text) ?? 0,
                  golonganDarah: golController.text,
                  imunisasiTerakhir: imunController.text,
                  kunjunganTerakhir: kunjunganController.text,
                );


                  if (anak == null) {
                    await FirebaseAnakService.addAnak(data);
                  } else {
                    await FirebaseAnakService.updateAnak(data);
                  }

                  if (mounted) Navigator.pop(context);
                },
                child: Text(anak == null ? "Simpan" : "Update"),
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

  Future<void> _delete(String id) async {
    await FirebaseAnakService.deleteAnak(id);
    setState(() {}); // refresh future
  }

  @override
  Widget build(BuildContext context) {
    if (currentUid == null) {
      return const Center(child: Text("User belum login"));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => _showForm(),
        child: const Icon(Icons.add),
      ),

      // ==================================================
      // === FUTUREBUILDER (Pengganti STREAMBUILDER) ===
      // ==================================================
      body: FutureBuilder<List<AnakFirebase>>(
        future: FirebaseAnakService.getAnakByUserFuture(currentUid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada data anak."));
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
                    'Jenis Kelamin: ${a.jenisKelamin}\n'
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
                        icon: const Icon(Icons.delete, color: Colors.teal),
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
