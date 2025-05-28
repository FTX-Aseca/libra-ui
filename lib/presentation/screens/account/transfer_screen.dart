import 'package:flutter/material.dart';
import 'package:libra_ui/presentation/widgets/shared/navbar.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text('Transfer')),
      bottomNavigationBar: NavBar.common(),
    );
  }
}
