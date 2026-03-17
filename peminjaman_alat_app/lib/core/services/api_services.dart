import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'storage_services.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Accept": "application/json",
        "ngrok-skip-browser-warning": "true",
      },
    ),
  );

static bool _initialized = false;

  static Dio get dio => _dio;

  static void initialize() {
    if (_initialized) return;
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await StorageService.getToken();
           print("TOKEN YANG DIKIRIM: $token");

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            await StorageService.deleteToken();
          } else if (e.type == DioExceptionType.connectionTimeout && !e.requestOptions.headers.containsKey('retry')) {
            try {
              // Retry the request on connection timeout
              final opts = e.requestOptions;
              opts.headers['retry'] = 'true';
              final response = await _dio.fetch(opts);
              return handler.resolve(response);
            } catch (retryError) {
              // If retry fails, propagate the error
            }
          }
          return handler.next(e);
        },
      ),
    );

     _initialized = true;
  }
}
