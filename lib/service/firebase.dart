import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_ppkd/model/user_firebase.dart';

class FirebaseService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // REGISTER USER
  static Future<UserFirebaseModel> registerUser({
    required String email,
    required String password,
    required String username,
    required String alamat,
    required String nomorHp,
    required String role,
  }) async {
    final cred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user!;

    final model = UserFirebaseModel(
      uid: user.uid,
      email: email,
      username: username,
      alamat: alamat,
      nomorHp: nomorHp,
      role: role,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    await firestore.collection('users').doc(user.uid).set(model.toMap());

    return model;
  }

  // LOGIN USER
  static Future<UserFirebaseModel?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // LOGIN YANG BENAR
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;

      if (user == null) return null;

      final data = await firestore.collection('users').doc(user.uid).get();

      if (!data.exists) return null;

      return UserFirebaseModel.fromMap(data.data()!);
    } catch (e) {
      return null;
    }
  }

  // GET USER DATA BY UID
  static Future<Map<String, dynamic>?> getUserData(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    return doc.data();
  }
  static Future<bool> updateUserData({
  required String uid,
  required String username,
  required String email,
  required String nomorHp,
  required String alamat,
}) async {
  try {
    await firestore.collection('users').doc(uid).update({
      "username": username,
      "email": email,
      "nomorHp": nomorHp,
      "alamat": alamat,
      "updatedAt": DateTime.now().toIso8601String(),
    });


    return true;
  } catch (e) {
    return false;
  }
}

}
