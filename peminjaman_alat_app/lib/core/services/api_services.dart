import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'storage_services.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        "Accept": "application/json",
      },
    ),
  );

  static Dio get dio => _dio;

  static void initialize() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await StorageService.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            await StorageService.deleteToken();
          }
          return handler.next(e);
        },
      ),
    );
  }
}
