import 'package:flutter/material.dart';
import 'package:libra_ui/presentation/widgets/shared/navbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Settings, Work in progress!')),
      bottomNavigationBar: NavBar.common(),
    );
  }
}
