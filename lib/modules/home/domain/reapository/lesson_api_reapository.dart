import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';

abstract class LessonApiReapositoryInterface {
  Future<Lesson> getLeson(int id);
}
