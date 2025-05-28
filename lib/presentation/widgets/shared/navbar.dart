import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class NavBar extends StatefulWidget {
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
  State<NavBar> createState() => _NavBarState();

  /// Named constructor for common styling
  factory NavBar.common() => const NavBar(
    cardBackgroundColor: LibraColors.cardBackground,
    accentColorTeal: LibraColors.accentTeal,
    secondaryTextColor: LibraColors.secondaryText,
  );
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final navBarItems = const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Home',
        key: ValueKey(AppRoutes.home),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.swap_horiz),
        label: 'Transfer',
        key: ValueKey(AppRoutes.transfer),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined),
        label: 'Settings',
        key: ValueKey(AppRoutes.settings),
      ),
    ];

    return BottomNavigationBar(
      currentIndex: _selectedIndex,
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
      onTap: (index) {
        setState(() => _selectedIndex = index);
        final parsedRoute = _parseRoute(index, navBarItems);
        // TODO: update selected index, refactor all screens as views
        context.goNamed(parsedRoute);
      },
    );
  }

  String _parseRoute(int index, List<BottomNavigationBarItem> navBarItems) =>
      (navBarItems[index].key as ValueKey<String>).value;
}
