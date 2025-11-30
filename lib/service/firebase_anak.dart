import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ppkd/model/anak_firebase.dart';

class FirebaseAnakService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collection = 'anak';
  
  // Referensi koleksi untuk digunakan di StreamBuilder
  static CollectionReference get anakRef => _firestore.collection(_collection);

  // Tambah data anak
  static Future<bool> addAnak(AnakFirebase anak) async {
    try {
      await _firestore.collection(_collection).add(anak.toMap());
      return true;
    } catch (e) {
      print('Error adding anak: $e');
      return false;
    }
  }

  // Update data anak
  static Future<bool> updateAnak(AnakFirebase anak) async {
    try {
      if (anak.id == null) return false;
      await _firestore.collection(_collection).doc(anak.id).update(anak.toMap());
      return true;
    } catch (e) {
      print('Error updating anak: $e');
      return false;
    }
  }

  // Delete data anak
  static Future<bool> deleteAnak(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
      return true;
    } catch (e) {
      print('Error deleting anak: $e');
      return false;
    }
  }

  // Get data anak berdasarkan parentId/userId (untuk orang tua)
  static Future<List<AnakFirebase>> getAnakByUserFuture(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs
          .map((doc) => AnakFirebase.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error getting anak by user: $e');
      return [];
    }
  }

  // PERBAIKAN: Get SEMUA data anak (untuk admin)
  static Future<List<AnakFirebase>> getAllAnak() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();

      return snapshot.docs
          .map((doc) => AnakFirebase.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      print('Error getting all anak: $e');
      return [];
    }
  }

  // Stream data anak berdasarkan userId (untuk real-time updates)
  static Stream<List<AnakFirebase>> getAnakByUserStream(String userId) {
    return _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AnakFirebase.fromMap(doc.id, doc.data()))
            .toList());
  }

  // TAMBAHAN: Stream SEMUA data anak (untuk admin real-time)
  static Stream<List<AnakFirebase>> getAllAnakStream() {
    return _firestore
        .collection(_collection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AnakFirebase.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Get single anak by ID
  static Future<AnakFirebase?> getAnakById(String id) async {
    try {
      final doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return AnakFirebase.fromMap(doc.id, doc.data()!);
      }
      return null;
    } catch (e) {
      print('Error getting anak by id: $e');
      return null;
    }
  }
}