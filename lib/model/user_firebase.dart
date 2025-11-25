import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserFirebaseModel {
  String? uid;
  String? username;
  String? email;
  String? password;
  String? alamat;
  String? nomorHp;
  String? jeniskelamin;
  int? jumlahAnak;
  String? role;
  String? createdAt;
  String? updatedAt;
  UserFirebaseModel({
    this.uid,
    this.username,
    this.email,
    this.password,
    this.alamat,
    this.nomorHp,
    this.jeniskelamin,
    this.jumlahAnak,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'username': username,
      'email': email,
      'password': password,
      'alamat': alamat,
      'nomorHp': nomorHp,
      'jeniskelamin': jeniskelamin,
      'jumlahAnak': jumlahAnak,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      alamat: map['alamat'] != null ? map['alamat'] as String : null,
      nomorHp: map['nomorHp'] != null ? map['nomorHp'] as String : null,
      jeniskelamin: map['jeniskelamin'] != null ? map['jeniskelamin'] as String : null,
      jumlahAnak: map['jumlahAnak'] != null ? map['jumlahAnak'] as int : null,
      role: map['role'] != null ? map['role'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFirebaseModel.fromJson(String source) => UserFirebaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
