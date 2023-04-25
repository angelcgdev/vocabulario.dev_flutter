import 'package:vocabulario_dev/domain/model/section.dart';

abstract class SectionsApiReapositoryInterface {
  Future<List<Section>> getSectionsListWithProgress(int userId);
}
