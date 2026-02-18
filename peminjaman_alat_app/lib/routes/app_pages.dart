import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/auth/splash_page.dart';
import 'package:peminjaman_alat_app/features/auth/login_page.dart';
import 'package:peminjaman_alat_app/features/home/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
    ),
  ];
}
