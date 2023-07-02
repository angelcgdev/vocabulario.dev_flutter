import 'package:vocabulario_dev/modules/home/modules/definition_report/domain/model/report.dart';

abstract class ReportsApiRepositoryInterface {
  Future<List<Report>> getReporsListByUserId(int userId);
  Future<List<Report>> getReporsList();
  Future<void> create(Report report);
}
