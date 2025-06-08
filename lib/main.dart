import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/constants/environment.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/theme.dart';

void main() async {
  await Environment.load();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: AppTheme.theme,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
