import 'package:mazraaty/Core/models/user.dart';

abstract class IUserRepository {
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> logoutUser();
}