import 'package:flutter/material.dart';
import 'dart:convert';

class Anak {
  final String nama;
  final String tanggalLahir;
  final String jenisKelamin;
  final double beratBadan; // kg
  final double tinggiBadan; // cm
  final double lingkarKepala; // cm
  final String golonganDarah;
  final String imunisasiTerakhir;
  final String kunjunganTerakhir;

  Anak({
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

  // Hitung usia dalam bulan
  int get usiaBulan {
    final lahir = DateTime.parse(tanggalLahir);
    final sekarang = DateTime.now();
    return (sekarang.year - lahir.year) * 12 + (sekarang.month - lahir.month);
  }

  // Hitung usia dalam tahun
  int get usiaTahun => usiaBulan ~/ 12;

  String get usiaString {
    final tahun = usiaTahun;
    final bulan = usiaBulan % 12;
    if (tahun > 0) {
      return bulan > 0 ? '$tahun tahun $bulan bulan' : '$tahun tahun';
    }
    return '$bulan bulan';
  }

  bool get isLakiLaki => jenisKelamin == 'Laki-laki';

  // Hitung IMT (Indeks Massa Tubuh)
  double get imt {
    final tinggiMeter = tinggiBadan / 100;
    return beratBadan / (tinggiMeter * tinggiMeter);
  }

  // Hitung Z-Score BB/TB (simplified - dalam real app gunakan tabel WHO)
  double get zScoreBBTB {
    // Ini contoh sederhana, seharusnya pakai tabel WHO lengkap
    final imtIdeal = 16.0; // IMT ideal untuk anak
    final sd = 2.0; // Standard deviation
    return (imt - imtIdeal) / sd;
  }

  // Status Gizi berdasarkan BB/TB atau IMT/U
  String get statusGizi {
    if (usiaTahun < 5) {
      // Untuk balita gunakan BB/TB
      return _getStatusGiziBBTB();
    } else {
      // Untuk anak > 5 tahun gunakan IMT/U
      return _getStatusGiziIMT();
    }
  }

  String _getStatusGiziBBTB() {
    final z = zScoreBBTB;
    if (z < -3) return 'Gizi Buruk (Severely Wasted)';
    if (z < -2) return 'Gizi Kurang (Wasted)';
    if (z >= -2 && z <= 2) return 'Gizi Baik (Normal)';
    if (z > 2 && z <= 3) return 'Berisiko Gizi Lebih (Possible Risk of Overweight)';
    return 'Gizi Lebih (Overweight)';
  }

  String _getStatusGiziIMT() {
    final z = zScoreBBTB;
    if (z < -3) return 'Sangat Kurus (Severely Thin)';
    if (z < -2) return 'Kurus (Thin)';
    if (z >= -2 && z <= 1) return 'Normal';
    if (z > 1 && z <= 2) return 'Gemuk (Overweight)';
    return 'Obesitas';
  }

  // Status Stunting berdasarkan TB/U
  String get statusStunting {
    // Simplified - seharusnya pakai tabel WHO berdasarkan usia dan jenis kelamin
    final tinggiIdeal = _getTinggiIdeal();
    final selisih = tinggiBadan - tinggiIdeal;
    
    if (selisih < -15) return 'Severely Stunted';
    if (selisih < -10) return 'Stunted';
    if (selisih >= -10 && selisih <= 10) return 'Normal';
    return 'Tinggi';
  }

  double _getTinggiIdeal() {
    // Contoh sederhana - seharusnya pakai tabel WHO lengkap
    if (isLakiLaki) {
      if (usiaTahun == 0) return 50 + (usiaBulan * 3);
      if (usiaTahun == 1) return 75;
      if (usiaTahun == 2) return 87;
      if (usiaTahun == 3) return 96;
      if (usiaTahun == 4) return 103;
      if (usiaTahun == 5) return 110;
      return 110 + ((usiaTahun - 5) * 6);
    } else {
      if (usiaTahun == 0) return 49 + (usiaBulan * 3);
      if (usiaTahun == 1) return 74;
      if (usiaTahun == 2) return 86;
      if (usiaTahun == 3) return 95;
      if (usiaTahun == 4) return 102;
      if (usiaTahun == 5) return 109;
      return 109 + ((usiaTahun - 5) * 6);
    }
  }

  // Warna status gizi
  Color get statusGiziColor {
    final status = statusGizi.toLowerCase();
    if (status.contains('normal') || status.contains('baik')) {
      return Colors.green;
    } else if (status.contains('kurang') || status.contains('kurus')) {
      return Colors.orange;
    } else if (status.contains('buruk') || status.contains('severely')) {
      return Colors.red;
    } else if (status.contains('lebih') || status.contains('gemuk') || 
               status.contains('obesitas') || status.contains('overweight')) {
      return Colors.orange.shade700;
    }
    return Colors.grey;
  }

  // Rekomendasi
  String get rekomendasiGizi {
    final status = statusGizi.toLowerCase();
    final stunting = statusStunting.toLowerCase();
    
    List<String> rekomendasi = [];
    
    if (status.contains('buruk') || status.contains('severely')) {
      rekomendasi.add('⚠️ SEGERA konsultasi dokter anak');
      rekomendasi.add('Berikan makanan bergizi tinggi');
      rekomendasi.add('Pertimbangkan suplemen vitamin');
    } else if (status.contains('kurang') || status.contains('kurus')) {
      rekomendasi.add('Tingkatkan asupan protein (telur, ikan, daging)');
      rekomendasi.add('Berikan camilan bergizi');
      rekomendasi.add('Konsultasi dengan ahli gizi');
    } else if (status.contains('lebih') || status.contains('obesitas')) {
      rekomendasi.add('Kurangi makanan tinggi gula dan lemak');
      rekomendasi.add('Tingkatkan aktivitas fisik');
      rekomendasi.add('Porsi makan seimbang');
    } else {
      rekomendasi.add('Pertahankan pola makan seimbang');
      rekomendasi.add('Aktivitas fisik rutin');
    }
    
    if (stunting.contains('stunted')) {
      rekomendasi.insert(0, '🚨 Terdeteksi STUNTING - konsultasi dokter');
    }
    
    return rekomendasi.join('\n');
  }

  // Gradient colors
  List<Color> get gradientColors => isLakiLaki
      ? [Colors.blue.shade300, Colors.blue.shade500]
      : [Colors.pink.shade300, Colors.pink.shade500];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
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

  factory Anak.fromMap(Map<String, dynamic> map) {
    return Anak(
      nama: map['nama'] as String,
      tanggalLahir: map['tanggalLahir'] as String,
      jenisKelamin: map['jenisKelamin'] as String,
      beratBadan: (map['beratBadan'] as num).toDouble(),
      tinggiBadan: (map['tinggiBadan'] as num).toDouble(),
      lingkarKepala: (map['lingkarKepala'] as num).toDouble(),
      golonganDarah: map['golonganDarah'] as String,
      imunisasiTerakhir: map['imunisasiTerakhir'] as String,
      kunjunganTerakhir: map['kunjunganTerakhir'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Anak.fromJson(String source) => 
      Anak.fromMap(json.decode(source) as Map<String, dynamic>);
}