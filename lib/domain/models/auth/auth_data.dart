import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:libra_ui/config/constants/constants.dart';

class AuthData extends Equatable {
  final String token;
  final String email;

  AuthData({required this.token, required this.email});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'] ?? 'No token provided',
      email: json['email'] ?? 'No email provided',
    );
  }

  factory AuthData.empty() =>
      AuthData(token: Constants.emptyString, email: Constants.emptyString);

  AuthData copyWith({String? token, String? email}) =>
      AuthData(token: token ?? this.token, email: email ?? this.email);

  int get id => int.parse((JwtDecoder.decode(token))['sub']);

  @override
  List<Object?> get props => [token, email];
}
