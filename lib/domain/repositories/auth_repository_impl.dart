import 'package:libra_ui/domain/models/auth/auth_data.dart';
import 'package:libra_ui/infrastructure/datasources/datasources.dart';
import 'package:libra_ui/infrastructure/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl({required AuthDatasource authDatasource})
    : _authDatasource = authDatasource;

  @override
  Future<AuthData> login({
    required String email,
    required String password,
  }) async => await _authDatasource.login(email: email, password: password);

  @override
  Future<void> logout() async => await _authDatasource.logout();

  @override
  Future<AuthData> register({
    required String email,
    required String password,
  }) async => await _authDatasource.register(email: email, password: password);
}
