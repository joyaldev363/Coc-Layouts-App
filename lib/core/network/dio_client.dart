import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_api.dart';
import '../constants/app_duration.dart';
import '../services/secure_storage_service.dart';

/// Provider for DioClient
final dioClientProvider = Provider<DioClient>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return DioClient(secureStorage);
});

/// DioClient configures and provides a Dio instance with interceptors.
class DioClient {
  late final Dio dio;
  final SecureStorageService _secureStorage;

  DioClient(this._secureStorage) {
    dio = Dio(BaseOptions(
      baseUrl: AppApi.baseUrl,
      connectTimeout: AppDuration.connectionTimeout,
      receiveTimeout: AppDuration.receiveTimeout,
      responseType: ResponseType.json,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Inject Bearer token if available
        final token = await _secureStorage.readData('auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        // Handle global error states (e.g., 401 Unauthorized refresh token logic)
        return handler.next(e);
      },
    ));
    
    // Add logging interceptor for debug mode
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }
}
