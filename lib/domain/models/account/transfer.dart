class Transfer {
  final String fromIdentifier;
  final IdentifierType identifierType;
  final double amount;

  Transfer({
    required this.fromIdentifier,
    required this.identifierType,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'fromIdentifier': fromIdentifier,
    'identifierType': identifierType.name.toUpperCase(),
    'amount': amount,
  };
}

enum IdentifierType { alias, cvu }
