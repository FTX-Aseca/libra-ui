import 'package:equatable/equatable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:libra_ui/config/constants/constants.dart';

class AuthData extends Equatable {
  final String token;
  final String email;
  final String alias;
  final String cvu;

  AuthData({
    required this.token,
    required this.email,
    required this.alias,
    required this.cvu,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'] ?? 'No token provided',
      email: json['email'] ?? 'No email provided',
      alias: json['alias'] ?? 'No alias provided',
      cvu: json['cvu'] ?? 'No cvu provided',
    );
  }

  factory AuthData.empty() => AuthData(
    token: Constants.emptyString,
    email: Constants.emptyString,
    alias: Constants.emptyString,
    cvu: Constants.emptyString,
  );

  AuthData copyWith({
    String? token,
    String? email,
    String? alias,
    String? cvu,
  }) => AuthData(
    token: token ?? this.token,
    email: email ?? this.email,
    alias: alias ?? this.alias,
    cvu: cvu ?? this.cvu,
  );

  int get id => int.parse((JwtDecoder.decode(token))['sub']);

  String get userName => email.split('@')[0];

  @override
  List<Object?> get props => [token, email, alias, cvu];
}
