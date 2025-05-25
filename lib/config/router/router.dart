import 'package:go_router/go_router.dart';
import 'package:libra_ui/presentation/screens/screens.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => const HomeScreen())],
);
