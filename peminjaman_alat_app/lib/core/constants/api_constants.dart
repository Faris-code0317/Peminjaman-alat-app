import 'package:peminjaman_alat_app/core/config/app_config.dart';

class ApiConstants {
    //Emulator
  // static const String baseUrl = "http://10.0.2.2:8000/api";

  //Device asli
  // static const String baseUrl = "http://192.168.110.215:8000/api";
  // static const String baseUrl = "http://192.168.110.215/peminjaman-alat/public/api";

  //Website
  // static const String baseUrl = "http://127.0.0.1:8000/api";

  //Laragon
  // static const String baseUrl = "http://peminjaman-alat.test/api";

  static String baseUrl = AppConfig.baseUrl;
  // static String baseUrl = "https://orthophosphoric-carolyne-unexplodable.ngrok-free.dev/api";
  
  static const String register = "/register";
  static const String login = "/login";
  static const String logout = "/logout";
  static const String refresh = "/refresh";

  static const String me = '/me';
  static const String alat = "/alat";
  static const String peminjaman = "/peminjaman";
  static const String peminjamanStatus = "/peminjaman/status";
}
