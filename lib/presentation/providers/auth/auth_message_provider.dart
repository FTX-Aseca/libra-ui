import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for displaying one-time messages on auth screens,
/// e.g., after registration before redirecting to login.
final authMessageProvider = StateProvider<String?>((ref) => null);
