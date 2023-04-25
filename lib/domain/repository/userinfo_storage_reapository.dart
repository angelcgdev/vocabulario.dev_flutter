import 'package:vocabulario_dev/domain/model/user.dart';

abstract class UserInfoStorageReapositoryInterface {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> deleteToken();
  Future<void> deleteUser();
}
