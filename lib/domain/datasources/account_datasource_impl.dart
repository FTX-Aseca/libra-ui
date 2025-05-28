import 'package:dio/dio.dart';
import 'package:libra_ui/domain/helpers/dio_builder.dart';
import 'package:libra_ui/domain/mappers/account/transaction_mapper.dart';
import 'package:libra_ui/domain/models/account/transaction.dart';
import 'package:libra_ui/domain/models/account/transfer.dart';
import 'package:libra_ui/infrastructure/datasources/account_datasource.dart';

class AccountDatasourceImpl extends AccountDatasource {
  final Dio _dio;

  AccountDatasourceImpl({required String token})
    : _dio = DioBuilder.fromDomain('',token: token);

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
}
