import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/widgets/home/home.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // 1. Header Tabs
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

            // 2. Flex Card
            _buildBalanceCard(),
            const SizedBox(height: 24),

            // 3. Activity Section Header
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

            // 4. Activity List
            Expanded(child: _buildActivityList()),
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
    final actionCards = [
      cardActionButton(Icons.info_outline, 'Details'),
      cardActionButton(Icons.star_border, 'Benefits'),
      cardActionButton(
        Icons.add_to_home_screen_outlined,
        'Add to Apple Wallet',
        isPrimary: true,
      ),
    ];
    return BalanceCard(actionCards: actionCards);
  }

  Widget _buildActivityList() {
    // TODO: receive the transaction list as a parameter
    // The parameter should be a list retrieved from Riverpod (using the API)
    return const TransactionHistory(
      cardBackgroundColor: LibraColors.cardBackground,
      accentColorTeal: LibraColors.accentTeal,
      primaryTextColor: LibraColors.primaryText,
      secondaryTextColor: LibraColors.secondaryText,
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
