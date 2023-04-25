import 'package:flutter/material.dart';
import 'package:vocabulario_dev/domain/model/report.dart';
import 'package:vocabulario_dev/domain/repository/reports_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/userinfo_storage_reapository.dart';

class ReportsTabController extends ChangeNotifier {
  final ReportsApiRepositoryInterface _reportService;

  ReportsTabController(
      {required ReportsApiRepositoryInterface reportService,
      required UserInfoStorageReapositoryInterface userInfo})
      : _reportService = reportService;

  Future<List<Report>> get getReports {
    return _reportService.getReporsList();
  }

  Future<void> simulateRefresh() async {
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }
}
