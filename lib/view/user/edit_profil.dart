import 'package:flutter/material.dart';
import 'package:project_ppkd/database/db_helper.dart';
import 'package:project_ppkd/preferences/preferences_handler.dart';
import 'package:project_ppkd/service/firebase.dart';

class EditProfilPage extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentNomorHp;
  final String currentAlamat;
  final String currentStatus;

  const EditProfilPage({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentNomorHp,
    required this.currentAlamat,
    required this.currentStatus,
  });

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController nomorhpController;
  late TextEditingController alamatController;

  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    nomorhpController = TextEditingController(text: widget.currentNomorHp);
    alamatController = TextEditingController(text: widget.currentAlamat);
    selectedStatus = widget.currentStatus;
  }

  Future<void> _saveChanges() async {
    await PreferencesHandler.saveUserData(
      nameController.text,
      emailController.text,
      nomorhpController.text,
      alamatController.text,
      selectedStatus!,

    );

    final uid = (await PreferencesHandler.getUserUid()) ?? '';
    print("Edit Profil UID: $uid");

    final success = await FirebaseService.updateUserData(
      uid: uid,
      username: nameController.text,
      email: emailController.text,
      nomorHp: nomorhpController.text,
      alamat: alamatController.text,
      statusPosyandu: selectedStatus!,
    );

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal update data ke Firebase")),
      );
      return;
    }

    final prefs = await PreferencesHandler.getPrefs();
    prefs.setString('userNomorHp', nomorhpController.text);
    prefs.setString('userAlamat', alamatController.text);

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil',style: TextStyle(color: Colors.white),),
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

            /// ---------------------- EMAIL (READONLY + SHADOW) ----------------------
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: emailController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ),
            /// ------------------------------------------------------------------------

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
      IgnorePointer(
      child: DropdownButtonFormField<String>(
                    value: selectedStatus,
                    decoration: const InputDecoration(
                      labelText: "Status Posyandu",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: "ibu_hamil",
                        child: Text("Ibu Hamil"),
                      ),
                      DropdownMenuItem(
                        value: "ortu_balita",
                        child: Text("Orang Tua Balita"),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
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
