import 'package:intl/intl.dart';

class Transaction {
  final String transactionType;
  final double amount;
  final DateTime? date;
  final String? description;

  String get formattedDate {
    if (date == null) return 'No date';
    return DateFormat.yMMMMd().format(date!);
  }

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
