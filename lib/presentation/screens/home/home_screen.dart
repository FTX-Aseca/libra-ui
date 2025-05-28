import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/widgets/home/home.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<List<Transaction>> _transactionsFuture;

  @override
  void initState() {
    super.initState();
    _transactionsFuture = ref.read(accountProvider.notifier).getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 16),

            const BalanceCard(),
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
                    onPressed: () => context.pushNamed(AppRoutes.transactions),
                    child: const Text(
                      'All >',
                      style: TextStyle(
                        color: LibraColors.accentTeal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder(
              future: _transactionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: LibraColors.accentTeal,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                print('loading transactions: ${snapshot.data}');
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        _transactionsFuture = ref
                            .read(accountProvider.notifier)
                            .getTransactions();
                      });
                      await _transactionsFuture;
                    },
                    child: _buildActivityList(snapshot.data ?? []),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildActivityList(List<Transaction> transactions) {
    return TransactionHistory(
      cardBackgroundColor: LibraColors.cardBackground,
      accentColorTeal: LibraColors.accentTeal,
      primaryTextColor: LibraColors.primaryText,
      secondaryTextColor: LibraColors.secondaryText,
      transactions: transactions,
      limit: transactions.length,
    );
  }

  Widget _buildBottomNavBar() => NavBar.common();
}
