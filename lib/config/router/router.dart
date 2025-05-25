import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';
import 'package:libra_ui/presentation/screens/screens.dart';
import 'package:libra_ui/presentation/screens/auth/login_screen.dart';
import 'package:libra_ui/presentation/screens/auth/register_screen.dart';

// It's good practice to define route names as constants
class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authRepositoryProvider);

  // A simple check for authentication.
  // Adjust this based on your actual AuthData model.
  // For example, if AuthData.empty() means not authenticated.
  // Or if there's an 'isAuthenticated' flag or a non-null user/token.
  final isAuthenticated = authState.token.isNotEmpty;

  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
    redirect: (context, state) {
      final loggingIn = state.matchedLocation == AppRoutes.login;
      final registering = state.matchedLocation == AppRoutes.register;
      final targetIsAuthRoute = loggingIn || registering;

      // If user is not authenticated:
      if (!isAuthenticated) {
        // If they are not already on login or register, redirect to login.
        if (!targetIsAuthRoute) {
          return AppRoutes.login;
        }
        // Allow access to login/register if not authenticated.
        return null;
      }

      // If user is authenticated:
      // If they are trying to access login or register, redirect to home.
      if (targetIsAuthRoute) {
        return AppRoutes.home;
      }

      // No redirection needed.
      return null;
    },
  );
});
