part of 'lesson_bloc.dart';

abstract class LessonEvent {}

class LessonFetched extends LessonEvent {
  final int id;
  LessonFetched(this.id);
}
class LessonSelected extends LessonEvent {
  final Lesson lesson;
  LessonSelected(this.lesson);
}