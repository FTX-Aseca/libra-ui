// This should represent the transaction history
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libra_ui/domain/models/account/external_transfer_response.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/presentation/providers/account/account_provider.dart';

class TransactionHistory extends ConsumerStatefulWidget {
  const TransactionHistory({
    super.key,
    required this.cardBackgroundColor,
    required this.accentColorTeal,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.transactions,
    this.externalTransfers = const [],
    this.limit = 10,
  });
  final Color cardBackgroundColor;
  final Color accentColorTeal;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final List<Transaction> transactions;
  final List<ExternalTransferResponse> externalTransfers;
  final int limit;

  @override
  ConsumerState<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends ConsumerState<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    final accountNotifier = ref.watch(accountProvider.notifier);
    final pendingExternalTransfers = widget.externalTransfers
        .where((e) => e.status.toUpperCase() != 'COMPLETED')
        .toList();

    if (widget.transactions.isEmpty && pendingExternalTransfers.isEmpty) {
      return const SizedBox.shrink();
    }
    final transactionListView = ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: widget.limit,
      itemBuilder: (context, index) {
        final transaction = widget.transactions[index];
        return _TransactionTile(
          cardBackgroundColor: widget.cardBackgroundColor,
          transaction: transaction,
          accentColorTeal: widget.accentColorTeal,
          primaryTextColor: widget.primaryTextColor,
          secondaryTextColor: widget.secondaryTextColor,
        );
      },
    );
    final externalTransferListView = ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: pendingExternalTransfers.length,
      itemBuilder: (context, index) {
        final externalTransfer = pendingExternalTransfers[index];
        return _ExternalTransferTile(
          cardBackgroundColor: widget.cardBackgroundColor,
          accentColorTeal: widget.accentColorTeal,
          primaryTextColor: widget.primaryTextColor,
          secondaryTextColor: widget.secondaryTextColor,
          externalTransfer: externalTransfer,
          onRefresh: () {
            accountNotifier.confirmExternalTransfer(externalTransfer);
            setState(() {});
          },
        );
      },
    );
    return Column(
      children: [
        Expanded(child: transactionListView),
        Expanded(child: externalTransferListView),
      ],
    );
  }
}

class _ExternalTransferTile extends StatelessWidget {
  const _ExternalTransferTile({
    Key? key,
    required this.cardBackgroundColor,
    required this.accentColorTeal,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.externalTransfer,
    required this.onRefresh,
  }) : super(key: key);

  final Color cardBackgroundColor;
  final Color accentColorTeal;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final ExternalTransferResponse externalTransfer;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final name = externalTransfer.operationType == OperationType.debin
        ? 'DEBIN Request'
        : 'Top-up Request';
    final icon = externalTransfer.operationType == OperationType.debin
        ? Icons.arrow_downward
        : Icons.arrow_upward;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: cardBackgroundColor.withValues(alpha: 0.9),
        child: Icon(icon, color: accentColorTeal, size: 20),
      ),
      title: Text(
        name,
        style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        externalTransfer.status,
        style: TextStyle(color: secondaryTextColor, fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${externalTransfer.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: primaryTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'ID: ${externalTransfer.id}',
                style: TextStyle(color: secondaryTextColor, fontSize: 10),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: accentColorTeal),
            onPressed: onRefresh,
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.cardBackgroundColor,
    required this.transaction,
    required this.accentColorTeal,
    required this.primaryTextColor,
    required this.secondaryTextColor,
  });

  final Color cardBackgroundColor;
  final Transaction transaction;
  final Color accentColorTeal;
  final Color primaryTextColor;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) {
    final transactionName = transaction.transactionType == 'INCOME'
        ? 'Received'
        : 'Sent';
    final icon = transaction.transactionType == 'INCOME'
        ? Icons.arrow_upward
        : Icons.arrow_downward;

    final transactionType = transaction.transactionType == 'INCOME' ? '+' : '-';
    final amount = '${transactionType}U\$D ${transaction.amount}';
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: cardBackgroundColor.withValues(alpha: 0.9),
        child: Icon(icon, color: accentColorTeal, size: 20),
      ),
      title: Text(
        transactionName,
        style: TextStyle(color: primaryTextColor, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        transaction.description ?? 'No description',
        style: TextStyle(color: secondaryTextColor, fontSize: 12),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: TextStyle(
              color: primaryTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            transaction.formattedDate,
            style: TextStyle(color: secondaryTextColor, fontSize: 10),
          ),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    );
  }
}
