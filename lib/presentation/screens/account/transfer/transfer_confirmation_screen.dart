import 'package:flutter/material.dart';
import 'package:libra_ui/config/theme/libra_colors.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/presentation/widgets/shared/shared.dart';

class TransferConfirmationScreen extends StatelessWidget {
  final String dest;
  final bool isAlias;
  final double amount;
  final OperationType operationType;
  final bool success;
  final String? errorMessage;

  const TransferConfirmationScreen({
    super.key,
    required this.dest,
    required this.isAlias,
    required this.amount,
    required this.operationType,
    this.success = true,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LibraColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                success ? Icons.check_circle : Icons.error,
                color: success ? LibraColors.accentTeal : Colors.red,
                size: 80,
              ),
              const SizedBox(height: 16),
              Text(
                success
                    ? (operationType == OperationType.transfer
                          ? 'Transfer Successful'
                          : operationType == OperationType.debin
                          ? 'DEBIN Request Sent'
                          : 'Top-Up Successful')
                    : (operationType == OperationType.transfer
                          ? 'Transfer Failed'
                          : operationType == OperationType.debin
                          ? 'DEBIN Request Failed'
                          : 'Top-Up Failed'),
                style: TextStyle(
                  color: success ? LibraColors.primaryText : Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              if (!success && errorMessage != null) ...[
                Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 24),
              ],
              if (success) ...[
                if (operationType != OperationType.topUp) ...[
                  _buildSummaryRow('Destination', dest),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Type', isAlias ? 'Alias' : 'CVU'),
                  const SizedBox(height: 8),
                ],
                _buildSummaryRow('Amount', '\$${amount.toStringAsFixed(2)}'),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavBar.common(),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: LibraColors.secondaryText)),
        Text(
          value,
          style: const TextStyle(
            color: LibraColors.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
