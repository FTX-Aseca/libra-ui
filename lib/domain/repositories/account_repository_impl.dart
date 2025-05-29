import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';
import 'package:libra_ui/infrastructure/datasources/account_datasource.dart';
import 'package:libra_ui/infrastructure/repositories/account_repository.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';

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

  @override
  Future<void> createTransfer(Transfer transfer) async {
    await _accountDatasource.createTransfer(transfer);
  }

  @override
  Future<void> createExternalTransfer(ExternalTransfer transfer) async {
    await _accountDatasource.createExternalTransfer(transfer);
  }

  @override
  Future<AuthData> getAccountDetails(int accountId) async =>
      await _accountDatasource.getAccountDetails(accountId);
}
