enum OperationType { debin, topUp, transfer }

class ExternalTransfer {
  final OperationType operationType;
  final double amount;

  ExternalTransfer({required this.operationType, required this.amount});

  Map<String, dynamic> toJson() => {'amount': amount};
}
