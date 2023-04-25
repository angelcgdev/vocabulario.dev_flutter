import 'package:flutter/material.dart';
import 'package:vocabulario_dev/domain/model/user.dart';
import 'package:vocabulario_dev/domain/repository/userinfo_storage_reapository.dart';

class ProfileTabController extends ChangeNotifier {
  final UserInfoStorageReapositoryInterface _userInfoStorage;

  ProfileTabController({
    required UserInfoStorageReapositoryInterface
        userInfoStorageReapositoryInterface,
  }) : _userInfoStorage = userInfoStorageReapositoryInterface;

  User _user = User.empty();
  User get user => _user;

  void init() async {
    getUser();
  }

  void getUser() async {
    final user = await _userInfoStorage.getUser();
    if (user != null) {
      _user = user;
      notifyListeners();
      return;
    }
    throw ErrorDescription('cannot get user');
  }

  Future<void> logout() async {
    await _userInfoStorage.deleteToken();
    await _userInfoStorage.deleteUser();
  }
}
