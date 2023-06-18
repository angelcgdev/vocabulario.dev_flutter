import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/lesson_api_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';

class LessonsServiceReapositoryImpl implements LessonApiReapositoryInterface {
  RequestServiceRepositoryInterface requestService;

  LessonsServiceReapositoryImpl({required this.requestService});
  @override
  Future<Lesson> getLeson(int id) {
    throw UnimplementedError();
  }
}
