
import 'package:sqflite/sqflite.dart' as sql;


//Employee(this.id, this.name, this.email, this.gender, this.password,
// this.tanggalLahir);

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
    CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, fullname TEXT, name TEXT, email TEXT, gender TEXT, password TEXT, tanggal_lahir TEXT , PathPhoto TEXT)
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('User.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> addUser(String fullname, String name, String email, String gender,
      String password, String tanggal_lahir) async {
    final db = await SQLHelper.db();
    print('add sudah sampe disini : $name');
    final data = {
      'fullname' : fullname,
      'name': name,
      'email': email,
      'gender': gender,
      'password': password,
      'tanggal_lahir': tanggal_lahir,
    };
    return await db.insert('User', data);
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await SQLHelper.db();
    return await db.query('User');
  }

  static Future<int> editUser(int id, String fullname, String name, String email,
      String gender, String password, String tanggal_lahir) async {
    final db = await SQLHelper.db();
    print('idnya adalah : $id');
    final data = {
      'fullname' : fullname,
      'name': name,
      'email': email,
      'gender': gender,
      'password': password,
      'tanggal_lahir': tanggal_lahir,
    };
    print('datanya: $data');
    return await db.update('User', data, where: "id = $id");
  }

  static Future<int> addPhoto(String PathPhoto, int id) async {
    final db = await SQLHelper.db();
    final data = {
      'PathPhoto': PathPhoto,
    };
    return await db.update('User', data, where: "id = $id");
  }


  static Future<Map<String, dynamic>?> getUserIdByUsernamePassword(
      String email, String password) async {
    final db = await SQLHelper.db();
    final results = await db.query('User',
        where: "email = ? AND password = ?", whereArgs: [email, password]);
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  static Future<int> deleteUser(int id) async {
    final db = await SQLHelper.db();
    return await db.delete('User', where: "id = $id");
  }



  //login

  static Future<List<Map<String, dynamic>>> login(
      String email, String password) async {
        print('ini pass sama user mau login : $email,$password');
    final db = await SQLHelper.db();
    return await db.rawQuery(
        "SELECT * FROM User WHERE email = '$email' AND password = '$password'");
  }

  //is email exist
  static Future<List<Map<String, dynamic>>> isEmailExist(String email) async {
    final db = await SQLHelper.db();
    return await db.rawQuery("SELECT * FROM User WHERE email = '$email'");
  }

  //is Login
  static Future<bool> isLogin(String email, String password) async {
    final db = await SQLHelper.db();
    final data = await db.rawQuery(
        "SELECT * FROM User WHERE email = '$email' AND password = '$password'");
    if (data.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
