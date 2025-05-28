import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';

class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key, this.actionCards = const <Widget>[]});

  final List<Widget> actionCards;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [
            LibraColors.accentSecondary,
            LibraColors.cardBackground.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Welcome, User!', // TODO: get user name from the backend
                style: TextStyle(
                  color: LibraColors.primaryText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Virtual',
                  style: TextStyle(color: LibraColors.accentTeal, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          balance.when(
            data: (value) => Text(
              'U\$D $value',
              style: const TextStyle(
                color: LibraColors.primaryText,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            loading: () => const SizedBox(
              height: 32,
              child: Center(
                child: CircularProgressIndicator(
                  color: LibraColors.accentTeal,
                  strokeWidth: 2,
                ),
              ),
            ),
            error: (err, stack) => const Text(
              'Error fetching balance',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '•••• 3079',
            style: TextStyle(
              color: LibraColors.secondaryText,
              fontSize: 16,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actionCards,
          ),
        ],
      ),
    );
  }
}
