import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;
  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection Time Out with Server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send Time Out with Server');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Recieve Time Out with Server');
      case DioExceptionType.badCertificate:
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response!.statusCode, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request Canceled');
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          return ServerFailure(errorMessage: 'No Internet Connection');
        } else {
          return ServerFailure(errorMessage: 'Unexpected Error, Try Again');
        }
      default:
        return ServerFailure(errorMessage: 'Unexpected Error, Try Again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errorMessage: response['message']);
    } else if (statusCode == 404) {
      return ServerFailure(
          errorMessage: 'Your Requested Content Not Found Try Again Later');
    } else if (statusCode == 422) {
      // Handle 422 Unprocessable Entity with error details
      if (response is Map<String, dynamic>) {
        final errorMessage = _parseValidationErrors(response);
        return ServerFailure(errorMessage: errorMessage);
      }
      return ServerFailure(errorMessage: 'Validation error occurred');
    } else if (statusCode == 500) {
      return ServerFailure(
          errorMessage: 'Internal Server Error Try Again Later');
    } else {
      return ServerFailure(
          errorMessage: response['message'] ?? 'Unexpected error occurred');
    }
  }

  static String _parseValidationErrors(Map<String, dynamic> response) {
    final buffer = StringBuffer();

    if (response.containsKey('errors') &&
        response['errors'] is Map<String, dynamic>) {
      final errors = response['errors'] as Map<String, dynamic>;

      errors.forEach((field, messages) {
        if (messages is List && messages.isNotEmpty) {
          // Add all messages for each field
          for (final message in messages) {
            buffer.writeln(message.toString());
          }
        }
      });
    }

    // If no errors found, return default message
    if (buffer.isEmpty) {
      buffer.write('Invalid data format received from server');
    }

    return buffer.toString().trim();
  }
}
