import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:dio/dio.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/presentation/views/account/transfer/transfer_confirmation_view.dart';

class TransferLoadingView extends ConsumerStatefulWidget {
  final String dest;
  final bool isAlias;
  final double amount;
  final OperationType operationType;

  const TransferLoadingView({
    super.key,
    required this.dest,
    required this.isAlias,
    required this.amount,
    required this.operationType,
  });

  @override
  ConsumerState<TransferLoadingView> createState() =>
      _TransferLoadingViewState();
}

class _TransferLoadingViewState extends ConsumerState<TransferLoadingView> {
  @override
  void initState() {
    super.initState();
    _performTransfer();
  }

  Future<void> _performTransfer() async {
    try {
      if (widget.operationType == OperationType.transfer) {
        final transfer = Transfer(
          toIdentifier: widget.dest,
          identifierType: widget.isAlias
              ? IdentifierType.alias
              : IdentifierType.cvu,
          amount: widget.amount,
        );
        // Attempt the transfer
        await ref.read(accountProvider.notifier).createTransfer(transfer);
      } else {
        final transfer = ExternalTransfer(
          operationType: widget.operationType,
          amount: widget.amount,
        );
        // Attempt the transfer
        await ref
            .read(accountProvider.notifier)
            .createExternalTransfer(transfer);
      }

      // On success
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TransferConfirmationView(
            dest: widget.dest,
            isAlias: widget.isAlias,
            amount: widget.amount,
            operationType: widget.operationType,
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
          builder: (_) => TransferConfirmationView(
            dest: widget.dest,
            isAlias: widget.isAlias,
            amount: widget.amount,
            operationType: widget.operationType,
            errorMessage: errorMessage,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: LibraColors.accentTeal),
    );
  }
}
