import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import 'api_services.dart';
import 'storage_services.dart';

class AuthService {
  static Future<Response> login({
    required String username,
    required String password,
  }) async {
    final response = await ApiService.dio.post(
      ApiConstants.login,
      data: {
        "username": username,
        "password": password,
      },
    );

    final token = response.data['token'];
    await StorageService.saveToken(token);

    return response;
  }

  static Future<Response> register({
    required String name,
    required String username,
    required String password,
  }) async {
    return await ApiService.dio.post(
      ApiConstants.register,
      data: {
        "name": name,
        "username": username,
        "password": password,
      },
    );
  }

  static Future<void> logout() async {
    await ApiService.dio.post(ApiConstants.logout);
    await StorageService.deleteToken();
  }
}
