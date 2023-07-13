part of 'lesson_bloc.dart';

enum LessonStatus { initial, loading, success, failure }

class LessonState extends Equatable {
  const LessonState({
    this.progress = const <Progress>[],
    this.status = LessonStatus.initial,
    this.terms = const <Term>[],
    this.lesson = Lesson.empty,
  });
  final List<Progress> progress;
  final List<Term> terms;
  final LessonStatus status;
  final Lesson lesson;

  LessonState copyWith({
    List<Progress>? progress,
   List<Term>? terms,
   LessonStatus? status,
   Lesson? lesson,
  }) {
    return LessonState(
      progress: progress ?? this.progress,
      terms: terms ?? this.terms,
      status: status ?? this.status,
      lesson: lesson ?? this.lesson,
    );
  }

  @override
  String toString() {
    return '''lesson: $lesson, status: $status, terms: ${terms.length}''';
  }

  @override
  List<Object?> get props => [progress, terms, status, lesson];
}
