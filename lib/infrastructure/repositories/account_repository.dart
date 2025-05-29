import 'package:libra_ui/domain/models/account/external_transfer_response.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';

abstract class AccountRepository {
  Future<double> getBalance(int accountId);

  Future<List<Transaction>> getTransactions(int accountId);

  Future<void> createTransfer(Transfer transfer);

  Future<ExternalTransferResponse> createExternalTransfer(ExternalTransfer transfer);

  Future<ExternalTransferResponse> confirmExternalTransfer(
    int transferId,
    OperationType operationType,
  );

  Future<AuthData> getAccountDetails(int accountId);
}
