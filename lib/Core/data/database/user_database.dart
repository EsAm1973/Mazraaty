import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDatabase {
  static final UserDatabase _instance = UserDatabase._internal();
  static Database? _database;

  UserDatabase._internal();

  factory UserDatabase() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE user(
            id INTEGER PRIMARY KEY,
            user_name TEXT,
            email TEXT,
            phone_number TEXT,
            points INTEGER,
            token TEXT,
            is_active INTEGER DEFAULT 0
          )
        ''');
      },
    );
  }
}
