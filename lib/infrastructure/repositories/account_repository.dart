import 'package:libra_ui/domain/models/account/transaction.dart';

abstract class AccountRepository {
  Future<double> getBalance(int accountId);

  Future<List<Transaction>> getTransactions(int accountId);
}
