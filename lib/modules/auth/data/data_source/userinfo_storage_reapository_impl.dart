import 'dart:convert';

import 'package:vocabulario_dev/modules/auth/domain/model/user.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';

class UserInfoStorageReapositoryImpl
    implements UserInfoStorageReapositoryInterface {
  final SecureStorageReapositoryInterface _secureStorageReapositoryInterface;
  UserInfoStorageReapositoryImpl(
      {required SecureStorageReapositoryInterface secureStorage})
      : _secureStorageReapositoryInterface = secureStorage;
  final _keyToken = 'token';
  final _keyUser = 'user';
  @override
  Future<String?> getToken() {
    return _secureStorageReapositoryInterface.read(_keyToken);
  }

  @override
  Future<User?> getUser() async {
    final userAsString =
        await _secureStorageReapositoryInterface.read(_keyUser);
    if (userAsString == null) return null;
    final user = User.fromJson(json.decode(userAsString));
    return user;
  }

  @override
  Future<void> saveToken(String token) async {
    return _secureStorageReapositoryInterface.write(_keyToken, token);
  }

  @override
  Future<void> saveUser(User user) async {
    final userToString = json.encode(user.toJson());
    _secureStorageReapositoryInterface.write(_keyUser, userToString);
  }

  @override
  Future<void> deleteToken() async {
    await _secureStorageReapositoryInterface.delete(_keyToken);
  }

  @override
  Future<void> deleteUser() async {
    await _secureStorageReapositoryInterface.delete(_keyUser);
  }
}
