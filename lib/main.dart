import 'package:flutter/material.dart';
import 'package:libra_ui/config/constants/environment.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environment.load();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Libra UI',
      theme: AppTheme.theme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
