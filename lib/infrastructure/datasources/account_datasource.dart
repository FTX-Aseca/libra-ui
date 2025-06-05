import 'package:libra_ui/domain/models/account/transaction.dart';

abstract class AccountDatasource {
  Future<double> getBalance(int accountId);

  Future<List<Transaction>> getTransactions(int accountId);

  Future<void> createTransaction(Transaction transaction, int receiverId);
}
