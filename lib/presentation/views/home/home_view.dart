import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/external_transfer_response.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/widgets/home/balance_card.dart';
import 'package:libra_ui/presentation/widgets/home/transaction_history.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    // Load transactions each time HomeView is shown
    Future.microtask(
      () => ref.read(accountProvider.notifier).getTransactions(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final balance = ref.watch(balanceProvider);
    final accountState = ref.watch(accountProvider);
    final transactions = accountState.transactions;
    final externalTransfers = accountState.externalTransfers;
    return Column(
      children: <Widget>[
        const SizedBox(height: 16),

        BalanceCard(balance: balance),
        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ACTIVITY',
                style: TextStyle(
                  color: LibraColors.primaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => context.push('${AppRoutes.home}/2'),
                child: const Text(
                  'All >',
                  style: TextStyle(color: LibraColors.accentTeal, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await ref.read(accountProvider.notifier).getTransactions();
              await ref.read(accountProvider.notifier).getBalance();
            },
            child: _buildActivityList(transactions, externalTransfers),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityList(
    List<Transaction> transactions,
    List<ExternalTransferResponse> externalTransfers,
  ) {
    return TransactionHistory(
      cardBackgroundColor: LibraColors.cardBackground,
      accentColorTeal: LibraColors.accentTeal,
      primaryTextColor: LibraColors.primaryText,
      secondaryTextColor: LibraColors.secondaryText,
      transactions: transactions,
      externalTransfers: externalTransfers,
      limit: transactions.length,
    );
  }
}
