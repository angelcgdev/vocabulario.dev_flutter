import 'package:flutter/widgets.dart';
import 'package:vocabulario_dev/modules/home/domain/model/section.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/sections_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';

class SectionTabController extends ChangeNotifier {
  SectionsApiReapositoryInterface sectionsService;
  UserInfoStorageReapositoryInterface userInfo;

  SectionTabController({required this.sectionsService, required this.userInfo});

  bool _isFloarintBtnVisible = false;
  int _counter = 0;

  Future<List<Section>> get getSections async {
    final user = await userInfo.getUser();
    return sectionsService.getSectionsListWithProgress(user!.id);
  }

  Future<void> simulateRefresh() async {
    isFloarintBtnVisible = false;
    await Future.delayed(const Duration(milliseconds: 500));
    _counter = _counter + 1;
    notifyListeners();
  }

  set isFloarintBtnVisible(bool value) {
    _isFloarintBtnVisible = value;
    notifyListeners();
  }

  bool get isFloarintBtnVisible => _isFloarintBtnVisible;
  int get counter => _counter;
}
