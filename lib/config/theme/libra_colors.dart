import 'package:flutter/material.dart';

class LibraColors {
  // Private constructor to prevent instantiation
  LibraColors._();

  // Approximated Colors from the image
  static const Color scaffoldBackground = Color(
    0xFF121A1A,
  ); // Darker background
  static const Color cardBackground = Color(
    0xFF1A2C2C,
  ); // Slightly lighter for card
  static const Color accentTeal = Color(0xFF4FD0C9); // Teal for highlights
  static const Color accentSecondary = Color(
    0xFF2E7570,
  ); // Darker teal for gradients or secondary elements
  static const Color primaryText = Colors.white;
  static const Color secondaryText = Colors.grey; // For less prominent text
  static const Color virtualTagBackground =
      Colors.black; // For the 'Virtual' tag
  static const Color shadow = Colors.black; // For boxShadows
}
