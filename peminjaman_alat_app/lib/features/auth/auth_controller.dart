import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:peminjaman_alat_app/core/services/auth_services.dart';
import 'package:peminjaman_alat_app/core/services/api_services.dart';
import 'package:peminjaman_alat_app/core/services/storage_services.dart';
import 'package:peminjaman_alat_app/core/constants/api_constants.dart';
class AuthController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;
  bool isLoggedIn = false;
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      isLoggedIn = false; 
      notifyListeners();

      await AuthService.login(
        username: username,
        password: password,
      );

      isLoggedIn = true;
    } catch (e) {
      isLoggedIn = false; 
      errorMessage = "Login gagal";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await AuthService.logout();
    isLoggedIn = false;
    notifyListeners();
  }

  Future<void> checkLogin() async {
  final token = await StorageService.getToken();
  print("TOKEN SAAT CHECK LOGIN: $token");

  if (token != null) {
    isLoggedIn = true;
  } else {
    isLoggedIn = false;
  }

  notifyListeners();
}

Future<bool> register({
  required String namaLengkap,
  required String username,
  required String password,
  required String confirmPassword,
}) async {
  isLoading = true;
  errorMessage = null;
  notifyListeners();

  try {
    final response = await ApiService.dio.post(
      ApiConstants.register,
      data: {
        "nama_lengkap": namaLengkap,
        "username": username,
        "password": password,
        "password_confirmation": confirmPassword,
      },
    );

    isLoading = false;
    notifyListeners();

    return response.statusCode == 201;
  } on DioException catch (e) {
    isLoading = false;
    errorMessage = e.response?.data["message"] ?? "Register gagal";
    notifyListeners();
    return false;
  }
}

}
