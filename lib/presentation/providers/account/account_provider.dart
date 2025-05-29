import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/datasources/account_datasource_impl.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/domain/repositories/account_repository_impl.dart';
import 'package:libra_ui/infrastructure/repositories/account_repository.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';

typedef AccountProvider = StateNotifierProvider<AccountNotifier, AccountState>;
final accountProvider = AccountProvider((ref) {
  final authData = ref.watch(authRepositoryProvider);

  final accountRepository = AccountRepositoryImpl(
    accountDatasource: AccountDatasourceImpl(token: authData.token),
  );

  return AccountNotifier(accountRepository, authData.id);
});

class AccountNotifier extends StateNotifier<AccountState> {
  final AccountRepository _accountRepository;
  final int accountId;
  AccountNotifier(this._accountRepository, this.accountId)
    : super(AccountState.initial());

  Future<List<Transaction>> getTransactions() async {
    final transactions = await _accountRepository.getTransactions(accountId);
    state = state.copyWith(transactions: transactions);
    return transactions;
  }

  Future<double> getBalance() async {
    final balance = await _accountRepository.getBalance(accountId);
    state = state.copyWith(balance: balance);
    return balance;
  }

  Future<void> createTransfer(Transfer transfer) async {
    await _accountRepository.createTransfer(transfer);
    // Refresh transactions after creation
    final updatedTransactions = await _accountRepository.getTransactions(
      accountId,
    );
    state = state.copyWith(transactions: updatedTransactions);
  }
}

class AccountState {
  final double balance;
  final List<Transaction> transactions;

  AccountState({required this.balance, required this.transactions});

  factory AccountState.initial() => AccountState(balance: 0, transactions: []);

  AccountState copyWith({double? balance, List<Transaction>? transactions}) =>
      AccountState(
        balance: balance ?? this.balance,
        transactions: transactions ?? this.transactions,
      );
}

final balanceProvider = FutureProvider<double>((ref) {
  final notifier = ref.read(accountProvider.notifier);
  return notifier.getBalance();
});
