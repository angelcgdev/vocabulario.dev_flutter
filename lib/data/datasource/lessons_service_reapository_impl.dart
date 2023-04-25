import 'package:vocabulario_dev/domain/model/lesson.dart';
import 'package:vocabulario_dev/domain/repository/lesson_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/request_service_reapository.dart';

class LessonsServiceReapositoryImpl implements LessonApiReapositoryInterface {
  RequestServiceRepositoryInterface requestService;

  LessonsServiceReapositoryImpl({required this.requestService});
  @override
  Future<Lesson> getLeson(int id) {
    throw UnimplementedError();
  }
}
