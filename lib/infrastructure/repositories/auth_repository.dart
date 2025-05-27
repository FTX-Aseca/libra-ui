import '../../domain/models/models.dart';

abstract class AuthRepository {
  Future<AuthData> login({required String email, required String password});
  Future<AuthData> register({required String email, required String password});
  Future<void> logout();
}
