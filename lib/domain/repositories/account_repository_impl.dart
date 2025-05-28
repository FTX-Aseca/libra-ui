import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/infrastructure/datasources/account_datasource.dart';
import 'package:libra_ui/infrastructure/repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountDatasource _accountDatasource;
  AccountRepositoryImpl({required AccountDatasource accountDatasource})
    : _accountDatasource = accountDatasource;
  @override
  Future<double> getBalance(int accountId) async =>
      await _accountDatasource.getBalance(accountId);

  @override
  Future<List<Transaction>> getTransactions(int accountId) async =>
      await _accountDatasource.getTransactions(accountId);
}
