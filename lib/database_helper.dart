import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'mydatabase.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Gambar(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        path STRING
      )""");

    await database.execute("""CREATE TABLE Kualitas(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nama TEXT, 
        keterangan TEXT,
        imagePath STRING,
        confidence REAL
      )""");
  }

  static Future<int> insertData(String table, Map<String, dynamic> data) async {
    final db = await DatabaseHelper.db();
    return await db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DatabaseHelper.db();
    return await db.query(table);
  }

  static Future<int> updateData(String table, int id, Map<String, dynamic> data) async {
    final db = await DatabaseHelper.db();
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteData(String table, int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint('Something went wrong when deleting data: $err');
    }
  }
}