import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/account/external_transfer_response.dart';

class ExternalTransferMapper {
  static ExternalTransferResponse withOperationType(
    OperationType operationType,
    Map<String, dynamic> json,
  ) {
    return ExternalTransferResponse(
      id: json['id'] as int,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      operationType: operationType,
    );
  }
}
