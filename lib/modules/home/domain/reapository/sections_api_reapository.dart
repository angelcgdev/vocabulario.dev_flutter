import 'package:vocabulario_dev/modules/home/domain/model/section.dart';

abstract class SectionsApiReapositoryInterface {
  Future<List<Section>> getSectionsListWithProgress(int userId);
}
