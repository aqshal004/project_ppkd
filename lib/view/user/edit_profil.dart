import 'package:flutter/material.dart';
import 'package:project_ppkd/database/db_helper.dart';
import 'package:project_ppkd/preferences/preferences_handler.dart';

class EditProfilPage extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentNomorHp;
  final String currentAlamat;

  const EditProfilPage({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentNomorHp,
    required this.currentAlamat,
  });

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController nomorhpController;
  late TextEditingController alamatController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    nomorhpController = TextEditingController(text: widget.currentNomorHp);
    alamatController = TextEditingController(text: widget.currentAlamat);
  }

  Future<void> _saveChanges() async {
    // Simpan data baru ke SharedPreferences
    await PreferencesHandler.saveUserData(
      nameController.text,
      emailController.text,
      nomorhpController.text,
      alamatController.text,
    );

    // Setelah saveUserData(...)
await DbHelper.updateUserData(
  widget.currentEmail, // email lama
  nameController.text,
  emailController.text,
  nomorhpController.text,
  alamatController.text,
);

    // Simpan juga nomor HP dan alamat (pakai key baru)
    final prefs = await PreferencesHandler.getPrefs();
    prefs.setString('userNomorHp', nomorhpController.text);
    prefs.setString('userAlamat', alamatController.text);

    // Tutup halaman dan kirim sinyal bahwa data diupdate
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nomorhpController,
              decoration: const InputDecoration(
                labelText: 'Nomor HP',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveChanges,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Simpan Perubahan",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
