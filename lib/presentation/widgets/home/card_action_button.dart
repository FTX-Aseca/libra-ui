import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class CardActionButton extends StatelessWidget {
  const CardActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final bool isPrimary;
  @override
  Widget build(BuildContext context) {
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
}
