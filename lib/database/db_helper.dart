import 'package:project_ppkd/model/user_model.dart';
import 'package:project_ppkd/model/anak_model.dart'; // TAMBAHKAN INI
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbHelper {
 static const tableUser = 'users';
 static const tableAnak = 'anak'; // TAMBAHKAN INI
 
 static Future<Database> db() async {
   final dbPath = await getDatabasesPath();
   return openDatabase(
     join(dbPath, 'posyandu.db'),
     onCreate: (db, version) async {
       // Tabel Users
       await db.execute(
         'CREATE TABLE $tableUser(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT, alamat TEXT, nomorHp TEXT, jeniskelamin TEXT, jumlahAnak INTEGER, role TEXT)',
       );
       
       // Tambahkan admin default
      await db.insert(
        tableUser,
        {
          'name': 'Admin Posyandu',
          'email': 'admin@gmail.com',
          'password': 'admin123', // bisa kamu ganti nanti
          'role': 'admin',
        },
      );

       // Tabel Anak - TAMBAHKAN INI
       await db.execute(
         'CREATE TABLE $tableAnak(id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, nama TEXT, tanggalLahir TEXT, jenisKelamin TEXT, beratBadan REAL, tinggiBadan REAL, lingkarKepala REAL, golonganDarah TEXT, imunisasiTerakhir TEXT, kunjunganTerakhir TEXT, FOREIGN KEY(userId) REFERENCES $tableUser(id))',
       );
     },
     version: 1,
   );
 } 
 
 static Future<void> registerUser(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final dbs = await db();
    //query adalah fungsi untuk menampilkan data (READ)
    final List<Map<String, dynamic>> results = await dbs.query(
      tableUser,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) {
      return UserModel.fromMap(results.first);
    }
    return null;
  }
  
  //MENAMBAHKAN SISWA
  static Future<void> createUser(UserModel user) async {
    final dbs = await db();
    //Insert adalah fungsi untuk menambahkan data (CREATE)
    await dbs.insert(
      tableUser,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print(user.toMap());
  }

   static Future<List<UserModel>> getALLUser() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableUser);
    print(results.map((e) => UserModel.fromMap(e)).toList());
    return results.map((e) => UserModel.fromMap(e)).toList();
  }
  
  // ============================================
  // TAMBAHAN METHOD UNTUK TABEL ANAK
  // ============================================
  
  // CREATE - Tambah data anak
  static Future<int> createAnak(Anak anak, int userId) async {
    final dbs = await db();
    final Map<String, dynamic> data = anak.toMap();
    data['userId'] = userId; // Tambahkan userId
    
    final id = await dbs.insert(
      tableAnak,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Anak berhasil ditambahkan dengan ID: $id');
    return id;
  }
  
  // // READ - Ambil semua data anak berdasarkan userId
  // static Future<List<Anak>> getAnakByUserId(int userId) async {
  //   final dbs = await db();
  //   final List<Map<String, dynamic>> results = await dbs.query(
  //     tableAnak,
  //     where: 'userId = ?',
  //     whereArgs: [userId],
  //     orderBy: 'nama ASC',
  //   );
  //   return results.map((e) => Anak.fromMap(e)).toList();
  // }
  
  // READ - Ambil semua data anak
  static Future<List<Anak>> getAllAnak() async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(tableAnak);
    return results.map((e) => Anak.fromMap(e)).toList();
  }
  
  // READ - Ambil satu data anak berdasarkan ID
  static Future<Anak?> getAnakById(int id) async {
    final dbs = await db();
    final List<Map<String, dynamic>> results = await dbs.query(
      tableAnak,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return Anak.fromMap(results.first);
    }
    return null;
  }
  
  // UPDATE - Update data anak
  static Future<int> updateAnak(Anak anak, int id) async {
    final dbs = await db();
    return await dbs.update(
      tableAnak,
      anak.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // DELETE - Hapus data anak
  static Future<int> deleteAnak(int id) async {
    final dbs = await db();
    return await dbs.delete(
      tableAnak,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  
  // READ - Hitung jumlah anak berdasarkan userId
  static Future<int> countAnakByUserId(int userId) async {
    final dbs = await db();
    final result = await dbs.rawQuery(
      'SELECT COUNT(*) as count FROM $tableAnak WHERE userId = ?',
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
}