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
        return ServerFailure(errorMessage: 'Connection timeout with server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send timeout with server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive timeout with server');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Invalid security certificate');
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException.response);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request canceled');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'Connection error - check network');
      case DioExceptionType.unknown:
        return _handleUnknownError(dioException);
      default:
        return ServerFailure(errorMessage: 'Unexpected error occurred');
    }
  }

  static ServerFailure _handleUnknownError(DioException dioException) {
    final message = dioException.message ?? '';
    if (message.contains('SocketException')) {
      return ServerFailure(errorMessage: 'No internet connection');
    }
    return ServerFailure(
      errorMessage: message.isNotEmpty
          ? message
          : 'Unknown error occurred', // Fixed typo here
    );
  }

  static ServerFailure _handleBadResponse(Response? response) {
    if (response == null) {
      return ServerFailure(errorMessage: 'Invalid server response');
    }

    try {
      return ServerFailure.fromResponse(
        response.statusCode,
        response.data,
      );
    } catch (e) {
      return ServerFailure(errorMessage: 'Error processing server response');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    final defaultMessage = 'Something went wrong. Please try again.';

    // Handle null or unexpected response format
    if (response is! Map<String, dynamic>) {
      return ServerFailure(errorMessage: defaultMessage);
    }

    final message = response['message']?.toString() ?? defaultMessage;

    switch (statusCode) {
      case 400:
        return ServerFailure(errorMessage: message);
      case 401:
        return ServerFailure(errorMessage: 'Authentication required');
      case 403:
        return ServerFailure(errorMessage: 'Access forbidden');
      case 404:
        return ServerFailure(
          errorMessage: 'Requested content not found',
        );
      case 500:
        return ServerFailure(
          errorMessage: 'Internal server error. Try again later.',
        );
      default:
        return ServerFailure(
          errorMessage: 'Unexpected error (code: $statusCode)',
        );
    }
  }
}
