import 'package:vocabulario_dev/modules/home/domain/model/lesson.dart';
import 'package:vocabulario_dev/modules/auth/domain/model/user.dart';

class Report {
  int id;
  String description;
  int userId;
  User? user;
  DateTime? date;
  int lessonId;
  Lesson? lesson;
  bool isCorrect;

  Report({
    required this.id,
    required this.userId,
    required this.description,
    this.user,
    this.date,
    required this.isCorrect,
    required this.lessonId,
    this.lesson,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      description: json['description'],
      date: DateTime.parse(json['completedAt']),
      userId: json['userId'],
      user: User.fromJson(json['user']),
      isCorrect: json['isCorrect'],
      lessonId: json['lessonId'],
      lesson: Lesson.fromJson(json['Lesson']),
    );
  }
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "lessonId": lessonId,
        "isCorrect": isCorrect,
        "description": description,
      };
}
