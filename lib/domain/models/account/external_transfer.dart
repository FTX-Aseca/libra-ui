import 'package:libra_ui/domain/models/account/transfer.dart';

enum OperationType { debin, topUp, transfer }

class ExternalTransfer {
  final OperationType operationType;
  final double amount;
  final IdentifierType? identifierType;
  final String? fromIdentifier;

  ExternalTransfer({
    required this.operationType,
    required this.amount,
    this.identifierType,
    this.fromIdentifier,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {'amount': amount};
    if (operationType == OperationType.debin) {
      json['identifierType'] = identifierType!.name.toUpperCase();
      json['fromIdentifier'] = fromIdentifier!;
    }
    return json;
  }
}
