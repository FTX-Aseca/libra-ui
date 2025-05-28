import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/widgets/home/card_action_button.dart';
import 'package:libra_ui/presentation/widgets/home/home.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final accountData = ref.watch(accountProvider.notifier);
    final transactionsFuture = accountData.getTransactions();

    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _tabItem('Cards', index: 0),
                  _tabItem('Payments', index: 1),
                  _tabItem('BillPay', index: 2),
                ],
              ),
            ),
            const SizedBox(height: 16),

            _buildBalanceCard(),
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
                    onPressed: () {
                      /* TODO: Handle 'All' press */
                    },
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
              future: transactionsFuture,
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
                return Expanded(child: _buildActivityList(snapshot.data ?? []));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _tabItem(String title, {required int index}) {
    final isSelected = currentIndex == index;
    final onTap = () => _onTabSelected(index);

    final textStyle = TextStyle(
      fontSize: 16,
      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
    );
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: isSelected
            ? LibraColors.accentTeal
            : LibraColors.secondaryText,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        overlayColor: Colors.transparent,
      ).copyWith(textStyle: WidgetStateProperty.all(textStyle)),
      onPressed: onTap,
      child: Text(title),
    );
  }

  Widget _buildBalanceCard() {
    final actionCards = const <CardActionButton>[
      CardActionButton(icon: Icons.info_outline, label: 'Details'),
      CardActionButton(icon: Icons.star_border, label: 'Benefits'),
      CardActionButton(
        icon: Icons.add_to_home_screen_outlined,
        label: 'Add to Apple Wallet',
        isPrimary: true,
      ),
    ];
    return BalanceCard(actionCards: actionCards);
  }

  Widget _buildActivityList(List<Transaction> transactions) {
    // TODO: receive the transaction list as a parameter
    // The parameter should be a list retrieved from Riverpod (using the API)
    return TransactionHistory(
      cardBackgroundColor: LibraColors.cardBackground,
      accentColorTeal: LibraColors.accentTeal,
      primaryTextColor: LibraColors.primaryText,
      secondaryTextColor: LibraColors.secondaryText,
      transactions: transactions,
    );
  }

  Widget _buildBottomNavBar() {
    return const NavBar(
      cardBackgroundColor: LibraColors.cardBackground,
      accentColorTeal: LibraColors.accentTeal,
      secondaryTextColor: LibraColors.secondaryText,
    );
  }

  void _onTabSelected(int index) {
    setState(() => currentIndex = index);
  }
}
