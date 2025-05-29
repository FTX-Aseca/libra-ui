import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';
import 'package:libra_ui/presentation/widgets/shared/navbar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authRepositoryProvider);
    final accountNotifier = ref.watch(accountProvider.notifier);
    final email = authData.email;
    final alias = email.contains('@') ? email.split('@')[0] : email;
    final cvu = accountNotifier.accountId.toString();
    void copyToClipboard(String label, String value) {
      Clipboard.setData(ClipboardData(text: value));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$label copied to clipboard')));
    }

    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  color: LibraColors.primaryText,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                title: const Text(
                  'Email',
                  style: TextStyle(color: LibraColors.primaryText),
                ),
                subtitle: Text(
                  email,
                  style: const TextStyle(color: LibraColors.secondaryText),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy, color: LibraColors.accentTeal),
                  onPressed: () => copyToClipboard('Email', email),
                ),
              ),
              const Divider(color: Colors.transparent, height: 1),
              ListTile(
                title: const Text(
                  'Alias',
                  style: TextStyle(color: LibraColors.primaryText),
                ),
                subtitle: Text(
                  alias,
                  style: const TextStyle(color: LibraColors.secondaryText),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy, color: LibraColors.accentTeal),
                  onPressed: () => copyToClipboard('Alias', alias),
                ),
              ),
              const Divider(color: Colors.transparent, height: 1),
              ListTile(
                title: const Text(
                  'CVU',
                  style: TextStyle(color: LibraColors.primaryText),
                ),
                subtitle: Text(
                  cvu,
                  style: const TextStyle(color: LibraColors.secondaryText),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.copy, color: LibraColors.accentTeal),
                  onPressed: () => copyToClipboard('CVU', cvu),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: call logout
                    ref.read(authRepositoryProvider.notifier).logout();
                    context.goNamed(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Logout', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar.common(),
    );
  }
}
