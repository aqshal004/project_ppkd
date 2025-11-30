import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ppkd/model/jadwal_firebase.dart';

class FirebaseJadwalService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference jadwalCollection =
      firestore.collection("jadwal_posyandu");

  // CREATE
  static Future<bool> tambahJadwal(JadwalPosyanduModel model) async {
    try {
      final doc = jadwalCollection.doc();

      model.id = doc.id;
      model.createdAt = DateTime.now().toIso8601String();
      model.updatedAt = DateTime.now().toIso8601String();

      await doc.set(model.toMap());
      return true;
    } catch (e) {
      print("Gagal tambah jadwal: $e");
      return false;
    }
  }

  // READ - semua jadwal
  static Future<List<JadwalPosyanduModel>> getAllJadwal() async {
    final snapshot = await jadwalCollection.orderBy('tanggal').get();
    return snapshot.docs
        .map((doc) => JadwalPosyanduModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // READ - by ID
  static Future<JadwalPosyanduModel?> getById(String id) async {
    final doc = await jadwalCollection.doc(id).get();
    if (!doc.exists) return null;
    return JadwalPosyanduModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  // UPDATE
  static Future<bool> updateJadwal(JadwalPosyanduModel model) async {
    try {
      await jadwalCollection.doc(model.id).update({
        ...model.toMap(),
        "updatedAt": DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print("Gagal update jadwal: $e");
      return false;
    }
  }

  // DELETE
  static Future<bool> hapusJadwal(String id) async {
    try {
      await jadwalCollection.doc(id).delete();
      return true;
    } catch (e) {
      print("Gagal hapus jadwal: $e");
      return false;
    }
  }
}
