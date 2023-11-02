import 'package:sqflite/sqflite.dart' as sql;

class SQLHelperGym{

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE gerakanGym(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        namaGerakan TEXT,
        deskripsi TEXT,
        tingkatKesulitan TEXT,
        gambar TEXT
      )   
    """);
  }
  static Future<sql.Database> db() async {
    return sql.openDatabase('gerakanGym.db', version: 1,
      onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addGerakanGym(String name,String deskripsi,String tingkatKesulitan,String gambar) async {
    print("nama : $name");
    final db = await SQLHelperGym.db();
    final data = {'namaGerakan' : name, 'deskripsi' : deskripsi,'tingkatKesulitan' : tingkatKesulitan,'gambar' : gambar};
    return await db.insert('gerakanGym',data);
  }

  static Future<List<Map<String,dynamic>>> getGerakanGym() async {
    final db = await SQLHelperGym.db();
    return db.query('gerakanGym');
  } 

 static Future<Map<String, dynamic>?> getGerakanGymBerdasarkanId(int id) async {
  final db = await SQLHelperGym.db();
  final results = await db.query('gerakanGym', where: 'id = ?', whereArgs: [id], limit: 1);
  
  if (results.isNotEmpty) {
    return results.first; // Mengambil elemen pertama dari hasil query
  } else {
    return null; // Mengembalikan null jika tidak ada data yang cocok
  }
}

static Future<int> editGerakanGym(int id, String name, String deskripsi, String tingkatKesulitan, String gambar) async {
  print('ini id yang mau di edit $id');
  final db = await SQLHelperGym.db();
  final data = {
    'namaGerakan': name,
    'deskripsi': deskripsi,
    'tingkatKesulitan': tingkatKesulitan,
  };
  
  // Gunakan klausa "where" dengan tanda tanya dan "whereArgs" untuk mengganti nilainya
  return await db.update('gerakanGym', data, where: "id = ?", whereArgs: [id]);
}

  static Future<int> deleteGerakanGym(int id) async {
    print('ini id yang mau di hapus $id');
    final db = await SQLHelperGym.db();
    return await db.delete('gerakanGym', where: "id = $id");
  }

  
}

