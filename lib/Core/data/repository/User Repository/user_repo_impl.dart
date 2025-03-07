import 'package:mazraaty/Core/data/database/user_database.dart';
import 'package:mazraaty/Core/data/repository/User%20Repository/user_repo.dart';
import 'package:mazraaty/Core/models/user.dart';
import 'package:sqflite/sqflite.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserDatabase userDatabase;

  UserRepositoryImpl({required this.userDatabase});

  @override
  Future<void> saveUser(User user) async {
    final db = await userDatabase.database;
    await db.insert(
      'user',
      {
        'id': user.id,
        'user_name': user.username,
        'email': user.email,
        'phone_number': user.phone,
        'points': user.points,
        'token': user.token,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<User?> getUser() async {
    final db = await userDatabase.database;
    List<Map<String, dynamic>> maps = await db.query('user', limit: 1);
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<void> deleteUser() async {
    final db = await userDatabase.database;
    await db.delete('user');
  }
}
