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
    // حفظ أو تحديث السجل مع تعيين is_active = 1
    await db.insert(
      'user',
      {
        'id': user.id,
        'user_name': user.username,
        'email': user.email,
        'phone_number': user.phone,
        'points': user.points,
        'token': user.token,
        'is_active': 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<User?> getUser() async {
    final db = await userDatabase.database;
    List<Map<String, dynamic>> maps = await db.query(
      'user',
      where: 'is_active = ?',
      whereArgs: [1],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    }
    return null;
  }

  // عند logout نقوم بتحديث السجل النشط بحيث نُفري بيانات الجلسة ونغير is_active إلى 0
  @override
  Future<void> logoutUser() async {
    final db = await userDatabase.database;
    await db.update(
      'user',
      {
        'user_name': '', // أو يمكن تركه كما هو إن أردت الاحتفاظ بالاسم
        'phone_number': '',
        'points': 0,
        'token': '',
        'is_active': 0,
      },
      where: 'is_active = ?',
      whereArgs: [1],
    );
  }
}
