import 'dart:io';

import 'package:dio/dio.dart';

/// Maps Dio errors to user-friendly error messages.
class ErrorMapper {
  static String mapError(Object error) {
    if (error is DioException) {
      // Handle HTTP response errors.
      if (error.response != null) {
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return 'Invalid request data or email already exists';
          case 401:
            return 'Invalid credentials';
          default:
            // Use API-provided description if available.
            final data = error.response?.data;
            if (data is Map<String, dynamic> && data['description'] is String) {
              return data['description'] as String;
            }
            return 'An unexpected error occurred (code $statusCode)';
        }
      }
      // Handle connection errors (e.g., socket exceptions).
      if (error.type == DioExceptionType.connectionError &&
          error.error is SocketException) {
        return 'Unable to connect with server. Please try again later';
      }
      // Fallback for other Dio errors.
      return error.message ?? 'An unexpected error occurred';
    }
    // Fallback for non-Dio errors.
    return error.toString();
  }
}
