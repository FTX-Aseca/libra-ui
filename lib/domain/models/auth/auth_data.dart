import 'package:equatable/equatable.dart';
import 'package:libra_ui/config/constants/constants.dart';

class AuthData extends Equatable {
  final String token;
  final String email;
  final String password;
  final double? id;

  AuthData({
    required this.token,
    required this.email,
    required this.password,
    this.id,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'] ?? 'No token provided',
      email: json['email'] ?? 'No email provided',
      password: json['password'] ?? 'No password provided',
      id: json['id']?.toDouble(),
    );
  }

  factory AuthData.empty() => AuthData(
    token: Constants.emptyString,
    email: Constants.emptyString,
    password: Constants.emptyString,
  );

  @override
  List<Object?> get props => [token, email, password];
}
