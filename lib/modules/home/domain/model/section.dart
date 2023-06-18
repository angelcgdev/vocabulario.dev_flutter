import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';

class Section {
  int id;
  String title;
  String? description;
  List<Lesson> lessons;
  Section(
      {required this.id,
      required this.title,
      this.description,
      required this.lessons});

  factory Section.fromJson(Map<String, dynamic> json) {
    final lessons = json['lessons'] as List;
    return Section(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        lessons: lessons.map((e) => Lesson.fromJson(e)).toList());
  }
}
