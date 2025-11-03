// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? alamat;
  String? nomorHp;
  String? jeniskelamin;
  int? jumlahAnak;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.alamat,
    this.nomorHp,
    this.jeniskelamin,
    this.jumlahAnak,
    this.role,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'alamat': alamat,
      'nomorHp': nomorHp,
      'jeniskelamin': jeniskelamin,
      'jumlahAnak': jumlahAnak,
      'role': role,

    };
  }

  

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      alamat: map['alamat'] != null ? map['alamat'] as String : null,
      nomorHp: map['nomorHp'] != null ? map['nomorHp'] as String : null,
      jeniskelamin: map['jeniskelamin'] != null ? map['jeniskelamin'] as String : null,
      jumlahAnak: map['jumlahAnak'] != null ? map['jumlahAnak'] as int : null,
      role: map['role'] != null ? map['role'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
