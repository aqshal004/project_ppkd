import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JadwalPosyanduModel {
  String? id;
  String? namaKegiatan;
  String? jenisKegiatan;
  String? tanggal;
  String? waktuMulai;
  String? waktuSelesai;
  String? lokasi;
  int? kuota;
  String? deskripsi;
  List<String>? agenda;
  String? createdAt;
  String? updatedAt;

  JadwalPosyanduModel({
    this.id,
    this.namaKegiatan,
    this.jenisKegiatan,
    this.tanggal,
    this.waktuMulai,
    this.waktuSelesai,
    this.lokasi,
    this.kuota,
    this.deskripsi,
    this.agenda,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'namaKegiatan': namaKegiatan,
      'jenisKegiatan': jenisKegiatan,
      'tanggal': tanggal,
      'waktuMulai': waktuMulai,
      'waktuSelesai': waktuSelesai,
      'lokasi': lokasi,
      'kuota': kuota,
      'deskripsi': deskripsi,
      'agenda': agenda,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory JadwalPosyanduModel.fromMap(Map<String, dynamic> map) {
    return JadwalPosyanduModel(
      id: map['id'] != null ? map['id'] as String : null,
      namaKegiatan:
          map['namaKegiatan'] != null ? map['namaKegiatan'] as String : null,
      jenisKegiatan:
          map['jenisKegiatan'] != null ? map['jenisKegiatan'] as String : null,
      tanggal: map['tanggal'] != null ? map['tanggal'] as String : null,
      waktuMulai:
          map['waktuMulai'] != null ? map['waktuMulai'] as String : null,
      waktuSelesai:
          map['waktuSelesai'] != null ? map['waktuSelesai'] as String : null,
      lokasi: map['lokasi'] != null ? map['lokasi'] as String : null,
      kuota: map['kuota'] != null ? map['kuota'] as int : null,
      deskripsi: map['deskripsi'] != null ? map['deskripsi'] as String : null,
      agenda: map['agenda'] != null
          ? List<String>.from(map['agenda'] as List)
          : <String>[],
      createdAt:
          map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt:
          map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory JadwalPosyanduModel.fromJson(String source) =>
      JadwalPosyanduModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
