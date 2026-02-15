import 'package:flutter/material.dart';
import 'package:peminjaman_alat_app/core/services/auth_services.dart';
import 'package:peminjaman_alat_app/core/services/storage_services.dart';


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

  Future<void> register({
    required String name,
    required String username,
    required String password,
  }) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      await AuthService.register(
        name: name,
        username: username,
        password: password,
      );
    } catch (e) {
      errorMessage = "Register gagal";
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

}
