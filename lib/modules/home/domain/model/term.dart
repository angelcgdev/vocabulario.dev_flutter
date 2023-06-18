class Term {
  int id;
  String title;
  String content;
  Term({required this.id, required this.title, required this.content});

  factory Term.fromJson(Map<String, dynamic> json) => Term(
        id: json['id'],
        title: json['title'],
        content: json['content'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };
}
