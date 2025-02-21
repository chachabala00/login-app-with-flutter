import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
    String path = join(await getDatabasesPath(), 'user_data.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, user_code TEXT, user_display_name TEXT, email TEXT, user_employee_code TEXT, company_code TEXT)",
        );
      },
    );
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      {
        'user_code': user['User_Code'],
        'user_display_name': user['User_Display_Name'],
        'email': user['Email'],
        'user_employee_code': user['User_Employee_Code'],
        'company_code': user['Company_Code'],
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
