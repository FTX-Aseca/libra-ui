import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';

abstract class AccountDatasource {
  Future<double> getBalance(int accountId);

  Future<List<Transaction>> getTransactions(int accountId);

  Future<void> createTransfer(Transfer transfer);

  Future<void> createExternalTransfer(ExternalTransfer transfer);

  Future<AuthData> getAccountDetails(int accountId);
}
