import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/widgets/home/transaction_history.dart';

class TransactionsView extends ConsumerStatefulWidget {
  const TransactionsView({super.key});

  @override
  ConsumerState<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends ConsumerState<TransactionsView> {
  @override
  void initState() {
    super.initState();
    // Fetch latest transactions and external transfers when view appears
    Future.microtask(
      () => ref.read(accountProvider.notifier).getTransactions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountProvider);
    final transactions = accountState.transactions;
    final externalTransfers = accountState.externalTransfers;

    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TransactionHistory(
              cardBackgroundColor: LibraColors.cardBackground,
              accentColorTeal: LibraColors.accentTeal,
              primaryTextColor: LibraColors.primaryText,
              secondaryTextColor: LibraColors.secondaryText,
              transactions: transactions,
              externalTransfers: externalTransfers,
              limit: transactions.length,
            ),
          ),
        ),
      ],
    );
  }
}
