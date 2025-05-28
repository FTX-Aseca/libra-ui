import 'package:libra_ui/domain/models/account/transaction.dart';

class TransactionMapper {
  static Transaction fromLibraAPI(Map<String, dynamic> json) {
    return Transaction(
      transactionType: json['type'],
      amount: json['amount'],
      date: DateTime.parse(json['timestamp']),
      description: json['description'],
    );
  }
}
