import 'package:vocabulario_dev/modules/auth/domain/model/models.dart';

class LoginResponse {
  final String token;
  final User user;
  const LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
      token: json['data']['token'], user: User.fromJson(json['data']['user']));
}
