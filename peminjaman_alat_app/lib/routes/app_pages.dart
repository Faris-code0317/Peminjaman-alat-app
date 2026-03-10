import 'package:get/get.dart';
import 'app_routes.dart';

import 'package:peminjaman_alat_app/features/auth/page/splash_page.dart';
import 'package:peminjaman_alat_app/features/auth/page/login_page.dart';
import 'package:peminjaman_alat_app/features/alat/page/alat_page.dart';
// import 'package:peminjaman_alat_app/features/alat/alatDetail_page.dart';

import 'package:peminjaman_alat_app/features/alat/controller/alat_controller.dart';

import 'package:peminjaman_alat_app/features/home/binding/home_binding.dart';
import 'package:peminjaman_alat_app/features/alat/binding/alat_binding.dart';
// import 'package:peminjaman_alat_app/binding/profile_binding.dart';

import 'package:peminjaman_alat_app/bottomNavbar.dart';

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
      // page: () => alatDetail_page(),
      page: () => HomePages(),
      bindings: [
        HomeBinding()
      ]
    ),
    GetPage(
      name: AppRoutes.ALATLIST,
      page: () => AlatList(alatController: AlatController(),),
      binding: AlatBinding()
    )
  ];
}
