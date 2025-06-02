// This should represent the transaction history
import 'package:flutter/material.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
    super.key,
    required this.cardBackgroundColor,
    required this.accentColorTeal,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.transactions,
    this.limit = 10,
  });
  final Color cardBackgroundColor;
  final Color accentColorTeal;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final List<Transaction> transactions;
  final int limit;

  @override
  Widget build(BuildContext context) {
    if (limit == 0) return const SizedBox.shrink();

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: limit,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _TransactionTile(
          cardBackgroundColor: cardBackgroundColor,
          transaction: transaction,
          accentColorTeal: accentColorTeal,
          primaryTextColor: primaryTextColor,
          secondaryTextColor: secondaryTextColor,
        );
      },
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
