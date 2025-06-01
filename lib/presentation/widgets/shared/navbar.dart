import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.cardBackgroundColor,
    required this.accentColorTeal,
    required this.secondaryTextColor,
  });

  final Color cardBackgroundColor;
  final Color accentColorTeal;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: cardBackgroundColor,
      selectedItemColor: accentColorTeal,
      unselectedItemColor: secondaryTextColor.withValues(alpha: 0.7),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment_outlined),
          label: 'Pay',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz),
          label: 'Transfer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart_outlined),
          label: 'Grow',
        ), // Changed icon
        BottomNavigationBarItem(
          icon: Icon(Icons.redeem_outlined),
          label: 'Rewards',
        ), // Changed icon
      ],
      onTap: (index) {
        // TODO: Handle navigation or state change for bottom nav
      },
    );
  }
}
