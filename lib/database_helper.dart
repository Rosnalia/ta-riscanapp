import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {

    await Permission.manageExternalStorage.request();
    final dbPath = await getDownloadsDirectory();

    Directory(dbPath!.path).create(recursive: true);

    final path = join(dbPath.path, 'kualitas.db');

    print('Database path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE Kualitas(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nama TEXT, 
        keterangan TEXT,
        imagePath STRING,
        confidence REAL
      )""");
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> updateData(
      String table, Map<String, dynamic> data, int id) async {
    final db = await database;
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteData(String table, int id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
