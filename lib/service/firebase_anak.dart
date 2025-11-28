import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ppkd/model/anak_firebase.dart';

class FirebaseAnakService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final CollectionReference anakRef =
      firestore.collection('anak');

  // ========================= ADD =========================
  static Future<bool> addAnak(AnakFirebase anak) async {
    try {
       final data = anak.toMap();
    data['userId'] = anak.userId ?? FirebaseAuth.instance.currentUser?.uid;
      await anakRef.add(anak.toMap());
      return true;
    } catch (e) {
      print("Error addAnak: $e");
      return false;
    }
  }

  // ========================= GET FUTURE =========================
  static Future<List<AnakFirebase>> getAnakByUserFuture(String userId) async {
    final snap = await anakRef.where("userId", isEqualTo: userId).get();

    return snap.docs
        .map((doc) =>
            AnakFirebase.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }

  // ========================= STREAM REALTIME =========================
  static Stream<List<AnakFirebase>> streamAnakByUser(String userId) {
    return anakRef
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snap) => snap.docs
            .map((doc) => AnakFirebase.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ))
            .toList());
  }

  // ========================= GET SINGLE =========================
  static Future<AnakFirebase?> getAnak(String id) async {
    try {
      final doc = await anakRef.doc(id).get();
      if (doc.exists) {
        return AnakFirebase.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print("Error getAnak: $e");
      return null;
    }
  }

  // ========================= UPDATE =========================
  static Future<bool> updateAnak(AnakFirebase anak) async {
    try {
      if (anak.id == null) return false;
      await anakRef.doc(anak.id).update(anak.toMap());
      return true;
    } catch (e) {
      print("Error updateAnak: $e");
      return false;
    }
  }

  // ========================= DELETE =========================
  static Future<bool> deleteAnak(String id) async {
    try {
      await anakRef.doc(id).delete();
      return true;
    } catch (e) {
      print("Error deleteAnak: $e");
      return false;
    }
  }
}
