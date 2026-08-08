import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'dio_client.dart';
import '../utils/logger.dart';

/// Provider for ApiClient
final apiClientProvider = Provider<ApiClient>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiClient(dioClient.dio, ref.watch(loggerProvider));
});

/// ApiClient handles core network communication using Dio.
class ApiClient {
  final Dio _dio;
  final Logger _logger;

  ApiClient(this._dio, this._logger);

  /// Performs a GET request.
  Future<Response> get(String url, {Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      _logger.e('GET Request failed on $url: ${e.message}');
      rethrow;
    }
  }

  /// Performs a POST request.
  Future<Response> post(String url, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.post(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      _logger.e('POST Request failed on $url: ${e.message}');
      rethrow;
    }
  }

  /// Performs a PUT request.
  Future<Response> put(String url, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.put(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      _logger.e('PUT Request failed on $url: ${e.message}');
      rethrow;
    }
  }

  /// Performs a DELETE request.
  Future<Response> delete(String url, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, CancelToken? cancelToken}) async {
    try {
      final response = await _dio.delete(url, data: data, queryParameters: queryParameters, options: options, cancelToken: cancelToken);
      return response;
    } on DioException catch (e) {
      _logger.e('DELETE Request failed on $url: ${e.message}');
      rethrow;
    }
  }
}
