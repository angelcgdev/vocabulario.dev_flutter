import 'package:vocabulario_dev/domain/model/lesson.dart';

abstract class LessonApiReapositoryInterface {
  Future<Lesson> getLeson(int id);
}
