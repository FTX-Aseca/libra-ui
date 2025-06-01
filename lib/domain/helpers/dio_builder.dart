import 'package:dio/dio.dart';
import 'package:libra_ui/config/constants/environment.dart';

class DioBuilder {
  static Dio fromDomain(String path, {String? token}) {
    if (token == null) {
      return Dio(BaseOptions(baseUrl: '${Environment.apiUrl}$path'));
    }
    return Dio(
      BaseOptions(
        baseUrl: '${Environment.apiUrl}$path',
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }
}
