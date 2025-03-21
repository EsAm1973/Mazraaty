// history_database.dart
import 'package:mazraaty/Features/history/data/models/history_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class HistoryDatabase {
  static final HistoryDatabase _instance = HistoryDatabase._internal();
  static Database? _database;

  HistoryDatabase._internal();

  factory HistoryDatabase() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'history.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE diseases(
            id INTEGER PRIMARY KEY,
            name TEXT,
            origin_name TEXT,
            scientific_name TEXT,
            also_know_as TEXT,
            type_disease TEXT,
            description TEXT,
            symptoms TEXT,
            solutions TEXT,
            preventions TEXT,
            home_remedys TEXT,
            disease_images TEXT,
            image_bytes BLOB,
            user_id INTEGER,
            FOREIGN KEY(user_id) REFERENCES user(id)
          )
        ''');
      },
    );
  }

  Future<int> insertDisease(HistoryDisease disease) async {
    final db = await database;
    return await db.insert('diseases', disease.toMap());
  }

  Future<int> deleteDisease(int id) async {
    final db = await database;
    return await db.delete(
      'diseases',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<HistoryDisease>> getDiseasesForUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'diseases',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) => HistoryDisease.fromMap(maps[i]));
  }
}