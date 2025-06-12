import 'package:libra_ui/domain/models/account/external_transfer.dart';

/// Model representing an external transfer response from the API.
class ExternalTransferResponse {
  final int id;
  final double amount;
  final String status;
  final OperationType operationType;

  ExternalTransferResponse({
    required this.id,
    required this.amount,
    required this.status,
    required this.operationType,
  });

  factory ExternalTransferResponse.fromJson(Map<String, dynamic> json) {
    final opTypeString = (json['operationType'] as String).toLowerCase();
    final opType = OperationType.values.firstWhere(
      (e) => e.name.toLowerCase() == opTypeString,
      orElse: () => OperationType.debin,
    );
    return ExternalTransferResponse(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      operationType: opType,
    );
  }
}
