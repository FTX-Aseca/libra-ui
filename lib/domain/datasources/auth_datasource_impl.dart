import 'package:libra_ui/config/constants/environment.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';
import 'package:libra_ui/infrastructure/datasources/auth_datasource.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final Dio _dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<AuthData> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthData.fromJson(response.data);
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
    await _dio.post(
      '/auth/register',
      data: {'email': email, 'password': password},
    );
    return AuthData.empty();
  }
}
