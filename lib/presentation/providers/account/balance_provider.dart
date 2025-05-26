import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/datasources/account_datasource_impl.dart';
import 'package:libra_ui/domain/repositories/account_repository_impl.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';

final balanceProvider = FutureProvider<double>((ref) async {
  final authData = ref.watch(authRepositoryProvider);
  final accountRepository = AccountRepositoryImpl(
    accountDatasource: AccountDatasourceImpl(token: authData.token),
  );
  return accountRepository.getBalance(authData.id);
});
