import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';
import 'package:libra_ui/presentation/screens/auth/login_screen.dart';
import 'package:libra_ui/presentation/screens/auth/register_screen.dart';
import 'package:libra_ui/presentation/screens/home/home_screen.dart';

// It's good practice to define route names as constants
class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String transactions = '/transactions';
  static const String transfer = '/transfer';

  static const List<String> values = [
    home,
    login,
    register,
    transactions,
    transfer,
  ];
}

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(
    authRepositoryProvider.select((data) => data.token.isNotEmpty),
  );
  final homeRoute = GoRoute(
    path: '${AppRoutes.home}/:page',
    name: AppRoutes.home,
    builder: (context, state) {
      final pageIndex = _getRouteIndex(state);
      if (pageIndex > 3 || pageIndex < 0) return const HomeScreen();
      return HomeScreen(pageIndex: pageIndex);
    },
  );
  final router = GoRouter(
    initialLocation: isAuthenticated ? '${AppRoutes.home}/0' : AppRoutes.login,
    routes: [
      homeRoute,
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
  // Listen to auth changes to redirect to login on logout
  ref.listen<AuthData>(authRepositoryProvider, (previous, next) {
    if (previous?.token.isNotEmpty == true && next.token.isEmpty) {
      router.go(AppRoutes.login);
    }
  });
  return router;
});

int _getRouteIndex(GoRouterState state) =>
    int.tryParse(state.pathParameters['page'] ?? '0') ?? 0;
