import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class LibraTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String semanticsFieldName;
  final String labelText;
  final String hintText;
  final IconData prefixIconData;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;

  const LibraTextFormField({
    super.key,
    required this.controller,
    required this.semanticsFieldName,
    required this.labelText,
    required this.hintText,
    required this.prefixIconData,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '${semanticsFieldName}_textfield',
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,focusNode: focusNode,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(prefixIconData, color: LibraColors.accentTeal),
          labelStyle: const TextStyle(color: LibraColors.secondaryText),
          hintStyle: TextStyle(
            color: LibraColors.secondaryText.withValues(alpha: 0.5),
          ),
          filled: true,
          fillColor: LibraColors.cardBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: LibraColors.secondaryText.withValues(alpha: 0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: LibraColors.accentTeal, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: LibraColors.primaryText),
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
      ),
    );
  }
}
