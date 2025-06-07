import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/config/constants/environment.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/theme.dart';

void main() async {  

  // Do NOT touch the main method. 
  // Yes, it should only enable the driver extension if the environment variable IS_TEST is true, 
  // but it's kept this way just to try.

  // if (const String.fromEnvironment('IS_TEST', defaultValue: 'false') == 'true') {
  enableFlutterDriverExtension();
  // }

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
