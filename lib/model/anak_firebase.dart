import 'package:flutter/material.dart';

class AnakFirebase {
  String? id;          // Firestore document ID
  String? userId;      // UID Firebase Auth
  final String nama;
  final String tanggalLahir;
  final String jenisKelamin;
  final double beratBadan; 
  final double tinggiBadan; 
  final double lingkarKepala; 
  final String golonganDarah;
  final String imunisasiTerakhir;
  final String kunjunganTerakhir;

  AnakFirebase({
    this.id,
    this.userId,
    required this.nama,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.beratBadan,
    required this.tinggiBadan,
    required this.lingkarKepala,
    required this.golonganDarah,
    required this.imunisasiTerakhir,
    required this.kunjunganTerakhir,
  });

  // ================= usia =================
  int get usiaBulan {
    try {
      final birth = DateTime.parse(tanggalLahir);
      final now = DateTime.now();
      return (now.year - birth.year) * 12 + now.month - birth.month;
    } catch (_) {
      return 0;
    }
  }

  int get usiaTahun => usiaBulan ~/ 12;

  String get usiaString {
    final t = usiaTahun;
    final b = usiaBulan % 12;
    if (t > 0) return b > 0 ? "$t tahun $b bulan" : "$t tahun";
    return "$b bulan";
  }

  bool get isLakiLaki => jenisKelamin == "Laki-laki";

  // ================= IMT =================
  double get imt {
    final m = tinggiBadan / 100;
    return beratBadan / (m * m);
  }

  double get zScoreBBTB {
    final mean = 16.0;
    final sd = 2.0;
    return (imt - mean) / sd;
  }

  String get statusGizi {
    if (usiaTahun < 5) return _statusGiziBBTB();
    return _statusGiziIMT();
  }

  String _statusGiziBBTB() {
    final z = zScoreBBTB;
    if (z < -3) return "Gizi Buruk (Severely Wasted)";
    if (z < -2) return "Gizi Kurang (Wasted)";
    if (z <= 2) return "Gizi Baik (Normal)";
    if (z <= 3) return "Berisiko Gizi Lebih";
    return "Gizi Lebih (Overweight)";
  }

  String _statusGiziIMT() {
    final z = zScoreBBTB;
    if (z < -3) return "Sangat Kurus (Severely Thin)";
    if (z < -2) return "Kurus (Thin)";
    if (z <= 1) return "Normal";
    if (z <= 2) return "Gemuk (Overweight)";
    return "Obesitas";
  }

  // ================= Stunting =================
  String get statusStunting {
    final ideal = _tinggiIdeal();
    final diff = tinggiBadan - ideal;

    if (diff < -15) return "Severely Stunted";
    if (diff < -10) return "Stunted";
    if (diff <= 10) return "Normal";
    return "Tinggi";
  }

  double _tinggiIdeal() {
    if (isLakiLaki) {
      if (usiaTahun == 0) return 50 + usiaBulan * 3;
      if (usiaTahun == 1) return 75;
      if (usiaTahun == 2) return 87;
      if (usiaTahun == 3) return 96;
      if (usiaTahun == 4) return 103;
      return 103 + (usiaTahun - 4) * 7;
    } else {
      if (usiaTahun == 0) return 49 + usiaBulan * 3;
      if (usiaTahun == 1) return 74;
      if (usiaTahun == 2) return 86;
      if (usiaTahun == 3) return 95;
      if (usiaTahun == 4) return 102;
      return 102 + (usiaTahun - 4) * 7;
    }
  }

  Color get statusGiziColor {
    final s = statusGizi.toLowerCase();
    if (s.contains("normal") || s.contains("baik")) return Colors.green;
    if (s.contains("kurang") || s.contains("kurus")) return Colors.orange;
    if (s.contains("buruk") || s.contains("severely")) return Colors.red;
    if (s.contains("lebih") || s.contains("gemuk") || s.contains("obesitas"))
      return Colors.orange.shade700;
    return Colors.grey;
  }

  String get rekomendasiGizi {
    final s = statusGizi.toLowerCase();
    final st = statusStunting.toLowerCase();
    List<String> r = [];

    if (st.contains("stunted")) {
      r.add("🚨 Stunting - konsultasi dokter segera");
    }

    if (s.contains("buruk")) {
      r.addAll([
        "Konsultasi dokter anak",
        "Makanan tinggi protein",
        "Vitamin tambahan"
      ]);
    } else if (s.contains("kurang")) {
      r.addAll([
        "Tambah protein (telur, ikan)",
        "Camilan sehat",
        "Cek ke ahli gizi"
      ]);
    } else if (s.contains("lebih") || s.contains("obesitas")) {
      r.addAll([
        "Kurangi gula & gorengan",
        "Aktivitas fisik",
        "Kontrol porsi"
      ]);
    } else {
      r.addAll([
        "Pertahankan gizi seimbang",
        "Aktivitas fisik rutin",
      ]);
    }

    return r.join("\n");
  }

  // ================= GRADIENT =================
  List<Color> get gradientColors =>
      isLakiLaki
          ? [Colors.blue.shade300, Colors.blue.shade500]
          : [Colors.pink.shade300, Colors.pink.shade500];

  // ================= Firestore Map =================
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'nama': nama,
      'tanggalLahir': tanggalLahir,
      'jenisKelamin': jenisKelamin,
      'beratBadan': beratBadan,
      'tinggiBadan': tinggiBadan,
      'lingkarKepala': lingkarKepala,
      'golonganDarah': golonganDarah,
      'imunisasiTerakhir': imunisasiTerakhir,
      'kunjunganTerakhir': kunjunganTerakhir,
    };
  }

  factory AnakFirebase.fromMap(String id, Map<String, dynamic> map) {
    return AnakFirebase(
      id: id,                 // gunakan Firestore doc.id
      userId: map['userId'],
      nama: map['nama'],
      tanggalLahir: map['tanggalLahir'],
      jenisKelamin: map['jenisKelamin'],
      beratBadan: (map['beratBadan'] as num).toDouble(),
      tinggiBadan: (map['tinggiBadan'] as num).toDouble(),
      lingkarKepala: (map['lingkarKepala'] as num).toDouble(),
      golonganDarah: map['golonganDarah'],
      imunisasiTerakhir: map['imunisasiTerakhir'],
      kunjunganTerakhir: map['kunjunganTerakhir'],
    );
  }
}
