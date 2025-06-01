import 'package:dio/dio.dart';
import 'package:libra_ui/domain/helpers/dio_builder.dart';
import 'package:libra_ui/infrastructure/datasources/account_datasource.dart';

class AccountDatasourceImpl extends AccountDatasource {
  final Dio _dio;

  AccountDatasourceImpl({required String token})
    : _dio = DioBuilder.fromDomain('/accounts', token: token);

  @override
  Future<double> getBalance(int accountId) async {
    final response = await _dio.get('/$accountId/balance');
    return response.data['balance'];
  }
}
