class Lesson {
  final int id;
  final String name;
  final String image;
  final List<Progress> terms;
  const Lesson(
      {required this.id,
      required this.name,
      required this.image,
      required this.terms});
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      terms: () {
        List<Progress> myList = [];
        final terms = json['terms'];
        if (terms != null) {
          return [...terms].map((e) => Progress.fromJson(e)).toList();
        }

        return myList;
      }(),
    );
  }

  static const empty = Lesson(id: 0, name: '', image: '', terms: []);
}

class Progress {
  final int id;
  final bool completed;
  const Progress({required this.id, required this.completed});

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'],
      completed: json['completed'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'completed': completed,
      };
}
