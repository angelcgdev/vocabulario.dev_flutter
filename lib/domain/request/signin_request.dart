class SignInRequest {
  String firstName;
  String lastName;
  String email;
  String password;
  String passqordConfirmation;
  SignInRequest(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.passqordConfirmation,
      required this.password});

  factory SignInRequest.fromJson(Map<String, String> json) => SignInRequest(
        email: json['email']!,
        firstName: json['firstName']!,
        lastName: json['lastName']!,
        password: json['password']!,
        passqordConfirmation: json['passwordConfirmation']!,
      );

  Map<String, String> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "passwordConfirmation": passqordConfirmation,
      };
}
