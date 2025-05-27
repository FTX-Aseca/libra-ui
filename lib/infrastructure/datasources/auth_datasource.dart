import 'package:libra_ui/domain/models/auth/auth_data.dart';

abstract class AuthDatasource {
  Future<AuthData> login({required String email, required String password});
  Future<AuthData> register({required String email, required String password});
  Future<void> logout();
}
