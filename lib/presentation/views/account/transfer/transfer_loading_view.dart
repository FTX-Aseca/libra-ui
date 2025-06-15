import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';
import 'package:dio/dio.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';

class TransferLoadingView extends ConsumerStatefulWidget {
  final String dest;
  final bool isAlias;
  final double amount;
  final OperationType operationType;
  final void Function(bool success, String? errorMessage) onComplete;

  const TransferLoadingView({
    super.key,
    required this.dest,
    required this.isAlias,
    required this.amount,
    required this.operationType,
    required this.onComplete,
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
          fromIdentifier: widget.dest,
          identifierType: widget.isAlias
              ? IdentifierType.alias
              : IdentifierType.cvu,
          amount: widget.amount,
        );
        // Attempt the transfer
        await ref.read(accountProvider.notifier).createTransfer(transfer);
      } else {
        late final ExternalTransfer transfer;
        if (widget.operationType == OperationType.debin) {
          transfer = ExternalTransfer(
            operationType: widget.operationType,
            amount: widget.amount,
            identifierType: widget.isAlias
                ? IdentifierType.alias
                : IdentifierType.cvu,
            fromIdentifier: widget.dest,
          );
        } else {
          transfer = ExternalTransfer(
            operationType: widget.operationType,
            amount: widget.amount,
          );
        }
        // Attempt the transfer
        await ref
            .read(accountProvider.notifier)
            .createExternalTransfer(transfer);
      }

      // On success
      if (!mounted) return;
      widget.onComplete(true, null);
    } catch (e) {
      String errorMessage;
      if (widget.operationType == OperationType.debin) {
        errorMessage = 'Unable to complete DEBIN. Balance not enough.';
      } else if (e is DioException &&
          e.response?.data is Map<String, dynamic>) {
        errorMessage =
            (e.response!.data['error'] as String?) ??
            e.message ??
            'An error occurred. Please try again.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }
      if (!mounted) return;
      widget.onComplete(false, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: LibraColors.accentTeal),
    );
  }
}
