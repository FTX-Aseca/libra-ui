import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.actionCards});

  final List<Widget> actionCards;

  @override
  Widget build(BuildContext context) {
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
                'AstroPay',
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
          const Text(
            'R\$ 4.660,00',
            style: TextStyle(
              color: LibraColors.primaryText,
              fontSize: 32,
              fontWeight: FontWeight.bold,
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

Widget cardActionButton(IconData icon, String label, {bool isPrimary = false}) {
  // Wrap with Flexible or Expanded if text can overflow in the Row
  return Flexible(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10), // Slightly larger padding
          decoration: BoxDecoration(
            color: isPrimary
                ? LibraColors.accentTeal.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.25),
            shape: BoxShape.circle,
            border: isPrimary
                ? Border.all(color: LibraColors.accentTeal)
                : null,
          ),
          child: Icon(
            icon,
            color: isPrimary
                ? LibraColors.accentTeal
                : LibraColors.primaryText.withValues(alpha: 0.8),
            size: 22,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: LibraColors.secondaryText,
            fontSize: 10,
          ),
          overflow: TextOverflow.ellipsis, // Handle long text
          maxLines: 2, // Allow up to two lines for label
        ),
      ],
    ),
  );
}
