import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/widgets/home/transaction_history.dart';

class TransactionsView extends ConsumerWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(accountProvider).transactions;
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
              limit: transactions.length,
            ),
          ),
        ),
      ],
    );
  }
}
