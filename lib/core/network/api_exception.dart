import 'package:dio/dio.dart';

/// ApiException defines structured error representations.
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? errorCode;

  ApiException({required this.message, this.statusCode, this.errorCode});

  factory ApiException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ApiException(message: "Request to API server was cancelled");
      case DioExceptionType.connectionTimeout:
        return ApiException(message: "Connection timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Receive timeout in connection with API server");
      case DioExceptionType.badResponse:
        return ApiException.fromResponse(dioError.response);
      case DioExceptionType.sendTimeout:
        return ApiException(message: "Send timeout in connection with API server");
      case DioExceptionType.connectionError:
        return ApiException(message: "No Internet Connection");
      case DioExceptionType.unknown:
      default:
        return ApiException(message: "Unexpected error occurred");
    }
  }

  factory ApiException.fromResponse(Response? response) {
    if (response == null) {
      return ApiException(message: 'Unknown response error');
    }
    
    final statusCode = response.statusCode;
    String message = 'Unknown Error';
    
    try {
      if (response.data is Map<String, dynamic> && response.data['message'] != null) {
        message = response.data['message'];
      } else {
        switch (statusCode) {
          case 400:
            message = 'Bad request';
            break;
          case 401:
            message = 'Unauthorized';
            break;
          case 403:
            message = 'Forbidden';
            break;
          case 404:
            message = 'Not found';
            break;
          case 500:
            message = 'Internal server error';
            break;
          default:
            message = 'Oops something went wrong';
            break;
        }
      }
    } catch (e) {
      message = 'Failed to parse error response';
    }

    return ApiException(
      message: message,
      statusCode: statusCode,
    );
  }

  @override
  String toString() => message;
}
