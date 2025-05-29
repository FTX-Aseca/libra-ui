import 'package:dio/dio.dart';
import 'package:libra_ui/domain/helpers/dio_builder.dart';
import 'package:libra_ui/domain/mappers/account/transaction_mapper.dart';
import 'package:libra_ui/domain/mappers/account/transfer/external_transfer_mapper.dart';
import 'package:libra_ui/domain/models/account/external_transfer.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/domain/models/auth/auth_data.dart';
import 'package:libra_ui/domain/models/account/external_transfer_response.dart';
import 'package:libra_ui/infrastructure/datasources/account_datasource.dart';

class AccountDatasourceImpl extends AccountDatasource {
  final Dio _dio;

  AccountDatasourceImpl({required String token})
    : _dio = DioBuilder.fromDomain('', token: token);

  @override
  Future<double> getBalance(int accountId) async {
    final response = await _dio.get('/accounts/$accountId/balance');
    return response.data['balance'];
  }

  @override
  Future<List<Transaction>> getTransactions(int accountId) async {
    final response = await _dio.get('/accounts/$accountId/transactions');
    final List<dynamic> data = response.data;
    return data
        .map(
          (transactionJson) => TransactionMapper.fromLibraAPI(
            transactionJson as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<void> createTransfer(Transfer transfer) async {
    await _dio.post('/transfers', data: transfer.toJson());
  }

  @override
  Future<ExternalTransferResponse> createExternalTransfer(
    ExternalTransfer transfer,
  ) async {
    final endpoint = switch (transfer.operationType) {
      OperationType.debin => '/debin/request',
      OperationType.topUp => '/topup',
      _ => throw UnimplementedError(),
    };
    final response = await _dio.post(endpoint, data: transfer.toJson());
    if (response.statusCode != 201) {
      throw Exception('Failed to create external transfer');
    }

    if (transfer.operationType == OperationType.topUp) {
      response.data['amount'] = transfer.amount;
    }
    return ExternalTransferMapper.withOperationType(
      transfer.operationType,
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<AuthData> getAccountDetails(int accountId) async {
    final response = await _dio.get('/accounts/$accountId');
    return AuthData.fromJson(response.data);
  }

  @override
  Future<ExternalTransferResponse> confirmExternalTransfer(
    int transferId,
    OperationType operationType,
  ) async {
    final endpoint = switch (operationType) {
      OperationType.debin => '/debin/callback',
      OperationType.topUp => '/topup/callback',
      _ => throw UnimplementedError(),
    };
    final response = await _dio.post(endpoint, data: {'id': transferId});
    return ExternalTransferMapper.withOperationType(
      operationType,
      response.data as Map<String, dynamic>,
    );
  }
}
