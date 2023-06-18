class User {
  final int id;
  final String fisrtName;
  final String lastName;
  final String email;
  final String? image;
  const User(
      {required this.id,
      required this.fisrtName,
      required this.lastName,
      required this.email,
      this.image});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        fisrtName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        image: json['image']);
  }
  factory User.empty() =>
      const User(id: 0, email: '', image: '', fisrtName: '', lastName: '');

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': fisrtName,
        'lastName': lastName,
        'email': email,
        'image': image,
      };
}
