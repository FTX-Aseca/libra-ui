import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/views/views.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final int pageIndex;
  const HomeScreen({super.key, this.pageIndex = 0});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final views = const [
    HomeView(),
    TransferView(),
    TransactionsView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        widget.pageIndex,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      key: const ValueKey('home_screen_key'),
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: views,
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(widget.pageIndex),
    );
  }

  Widget _buildBottomNavBar(int currentIndex) => NavBar.common(currentIndex);

  @override
  bool get wantKeepAlive => true;
}
