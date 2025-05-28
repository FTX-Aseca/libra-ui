import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';

abstract class AccountDatasource {
  Future<double> getBalance(int accountId);

  Future<List<Transaction>> getTransactions(int accountId);

  Future<void> createTransfer(Transfer transfer);
}
