import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class NavBar extends StatefulWidget {
  const NavBar({
    super.key,
    required this.cardBackgroundColor,
    required this.accentColorTeal,
    required this.secondaryTextColor,
    required this.currentIndex,
  });

  final Color cardBackgroundColor;
  final Color accentColorTeal;
  final Color secondaryTextColor;
  final int currentIndex;

  @override
  State<NavBar> createState() => _NavBarState();

  factory NavBar.common(int currentIndex) => NavBar(
    cardBackgroundColor: LibraColors.cardBackground,
    accentColorTeal: LibraColors.accentTeal,
    secondaryTextColor: LibraColors.secondaryText,
    currentIndex: currentIndex,
  );
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final navBarItems = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Transfer'),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Transactions'),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined),
        label: 'Settings',
      ),
    ];

    return BottomNavigationBar(
      currentIndex: widget.currentIndex,
      backgroundColor: widget.cardBackgroundColor,
      selectedItemColor: widget.accentColorTeal,
      unselectedItemColor: widget.secondaryTextColor.withValues(alpha: 0.7),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      items: navBarItems,
      onTap: (index) => context.go('/home/$index'),
    );
  }
}
