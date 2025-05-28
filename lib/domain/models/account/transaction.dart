class Transaction {
  final String transactionType;
  final double amount;
  final DateTime? date;
  final String? description;

  Transaction({
    required this.transactionType,
    required this.amount,
    this.date,
    this.description,
  });

  Map<String, dynamic> toJson() => {
    'type': transactionType,
    'amount': amount,
    'description': description,
  };
}
