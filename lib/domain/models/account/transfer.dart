class Transfer {
  final String toIdentifier;
  final IdentifierType identifierType;
  final double amount;

  Transfer({
    required this.toIdentifier,
    required this.identifierType,
    required this.amount,
  });

  Map<String, dynamic> toJson() => {
    'toIdentifier': toIdentifier,
    'identifierType': identifierType.name.toUpperCase(),
    'amount': amount,
  };
}

enum IdentifierType { alias, cvu }
