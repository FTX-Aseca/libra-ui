import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${text.toLowerCase().replaceAll(' ', '_')}_button',
      button: true, // Indicate that this is a button for accessibility
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: LibraColors.accentTeal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ).copyWith(
              foregroundColor: WidgetStateProperty.all(LibraColors.primaryText),
            ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white, // Consider using a theme color here
                  strokeWidth: 2,
                ),
              )
            : Text(text),
      ),
    );
  }
}
