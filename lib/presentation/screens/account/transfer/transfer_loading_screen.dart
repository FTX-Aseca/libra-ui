import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:dio/dio.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/screens/account/transfer/transfer_confirmation_screen.dart';

class TransferLoadingScreen extends ConsumerStatefulWidget {
  final String dest;
  final bool isAlias;
  final double amount;

  const TransferLoadingScreen({
    super.key,
    required this.dest,
    required this.isAlias,
    required this.amount,
  });

  @override
  ConsumerState<TransferLoadingScreen> createState() =>
      _TransferLoadingScreenState();
}

class _TransferLoadingScreenState extends ConsumerState<TransferLoadingScreen> {
  @override
  void initState() {
    super.initState();
    _performTransfer();
  }

  Future<void> _performTransfer() async {
    try {
      final transfer = Transfer(
        toIdentifier: widget.dest,
        identifierType: widget.isAlias
            ? IdentifierType.alias
            : IdentifierType.cvu,
        amount: widget.amount,
      );
      // Attempt the transfer
      await ref.read(accountProvider.notifier).createTransfer(transfer);
      // On success
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TransferConfirmationScreen(
            dest: widget.dest,
            isAlias: widget.isAlias,
            amount: widget.amount,
          ),
        ),
      );
    } catch (e) {
      // Extract error message
      final errorMessage =
          (e is DioException && e.response?.data is Map<String, dynamic>)
          ? (e.response!.data['error'] as String? ?? e.message)
          : e.toString();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TransferConfirmationScreen(
            dest: widget.dest,
            isAlias: widget.isAlias,
            amount: widget.amount,
            errorMessage: errorMessage,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: Center(
        child: CircularProgressIndicator(color: LibraColors.accentTeal),
      ),
    );
  }
}
