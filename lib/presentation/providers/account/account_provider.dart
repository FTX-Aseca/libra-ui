import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/datasources/account_datasource_impl.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/account/external_transfer_response.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/domain/repositories/account_repository_impl.dart';
import 'package:libra_ui/infrastructure/repositories/account_repository.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';

typedef AccountProvider = StateNotifierProvider<AccountNotifier, AccountState>;
final accountProvider = AccountProvider.autoDispose((ref) {
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

  Future<void> createExternalTransfer(ExternalTransfer transfer) async {
    final externalTransferResponse = await _accountRepository
        .createExternalTransfer(transfer);
    // Refresh transactions after creation
    final updatedTransactions = await _accountRepository.getTransactions(
      accountId,
    );
    state = state.copyWith(
      transactions: updatedTransactions,
      externalTransfers: [...state.externalTransfers, externalTransferResponse],
    );
  }

  Future<void> confirmExternalTransfer(
    ExternalTransferResponse externalTransfer,
  ) async {
    final updatedExternalTransferResponse = await _accountRepository
        .confirmExternalTransfer(
          externalTransfer.id,
          externalTransfer.operationType,
        );
    state.externalTransfers.removeWhere(
      (element) => element.id == externalTransfer.id,
    );
    state = state.copyWith(
      externalTransfers: [
        ...state.externalTransfers,
        updatedExternalTransferResponse,
      ],
    );
  }
}

class AccountState {
  final double balance;
  final List<Transaction> transactions;
  final List<ExternalTransferResponse> externalTransfers;

  AccountState({
    required this.balance,
    required this.transactions,
    this.externalTransfers = const [],
  });

  factory AccountState.initial() => AccountState(balance: 0, transactions: []);

  AccountState copyWith({
    double? balance,
    List<Transaction>? transactions,
    List<ExternalTransferResponse>? externalTransfers,
  }) => AccountState(
    balance: balance ?? this.balance,
    transactions: transactions ?? this.transactions,
    externalTransfers: externalTransfers ?? this.externalTransfers,
  );
}

final balanceProvider = FutureProvider.autoDispose<double>((ref) {
  final authData = ref.watch(authRepositoryProvider);
  if (authData.token.isEmpty) {
    return Future.value(-1.0); // Negative balance indicates an invalid state
  }
  final notifier = ref.read(accountProvider.notifier);
  return notifier.getBalance();
});
