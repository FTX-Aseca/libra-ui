import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get apiUrl => dotenv.env['API_URL'] ?? 'No API URL set';
  static Future<void> load() async => await dotenv.load();
}
