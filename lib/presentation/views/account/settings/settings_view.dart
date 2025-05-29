import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:libra_ui/config/router/router.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/providers/auth/auth_provider.dart';
import 'package:libra_ui/domain/models/models.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void copyToClipboard(String label, String value) {
      Clipboard.setData(ClipboardData(text: value));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$label copied to clipboard')));
    }

    return Padding(
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
          _AccountDetailsList(onCopy: copyToClipboard),
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
    );
  }
}

// Private widget to display account details with copy functionality
class _AccountDetailsList extends ConsumerWidget {
  final void Function(String, String) onCopy;
  const _AccountDetailsList({Key? key, required this.onCopy}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<void>(
      future: ref.read(authRepositoryProvider.notifier).getAccountDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: \\${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        final data = ref.watch(authRepositoryProvider);
        return Column(children: _buildDetailItems(data));
      },
    );
  }

  List<Widget> _buildDetailItems(AuthData data) => [
    _AccountDetailItem(label: 'Email', value: data.email, onCopy: onCopy),
    const Divider(color: Colors.transparent, height: 1),
    _AccountDetailItem(label: 'Alias', value: data.alias, onCopy: onCopy),
    const Divider(color: Colors.transparent, height: 1),
    _AccountDetailItem(label: 'CVU', value: data.cvu, onCopy: onCopy),
  ];
}

// Private widget for a single account detail row
class _AccountDetailItem extends StatelessWidget {
  final String label;
  final String value;
  final void Function(String, String) onCopy;

  const _AccountDetailItem({
    Key? key,
    required this.label,
    required this.value,
    required this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: const TextStyle(color: LibraColors.primaryText),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(color: LibraColors.secondaryText),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.copy, color: LibraColors.accentTeal),
        onPressed: () => onCopy(label, value),
      ),
    );
  }
}
