import 'package:libra_ui/domain/helpers/dio_builder.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';
import 'package:libra_ui/infrastructure/datasources/auth_datasource.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio = DioBuilder.fromDomain('/auth');

  @override
  Future<AuthData> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );

    AuthData authData = AuthData.fromJson(response.data);
    if (authData.email.isEmpty) {
      authData = authData.copyWith(email: email);
    }
    return authData;
  }

  @override
  Future<void> logout() async {
    // TODO: implement logout
  }

  @override
  Future<AuthData> register({
    required String email,
    required String password,
  }) async {
    // We only need to perform the register, not get the data.
    final response = await _dio.post(
      '/register',
      data: {'email': email, 'password': password},
    );
    return AuthData.fromJson(response.data);
  }
}
