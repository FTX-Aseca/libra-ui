import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/datasources/auth_datasource_impl.dart';
import 'package:libra_ui/domain/models/models.dart';
import 'package:libra_ui/domain/repositories/auth_repository_impl.dart';
import 'package:libra_ui/infrastructure/repositories/auth_repository.dart';

final authRepositoryProvider = StateNotifierProvider<AuthNotifier, AuthData>(
  (ref) => AuthNotifier(
    authRepository: AuthRepositoryImpl(authDatasource: AuthDatasourceImpl()),
  ),
);

class AuthNotifier extends StateNotifier<AuthData> {
  final AuthRepository _authRepository;

  AuthNotifier({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthData.empty());

  Future<void> login({required String email, required String password}) async {
    final authData = await _authRepository.login(
      email: email,
      password: password,
    );
    state = state.copyWith(token: authData.token);
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    state = await _authRepository.register(email: email, password: password);
  }
}
