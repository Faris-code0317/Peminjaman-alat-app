import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:peminjaman_alat_app/routes/app_pages.dart';
import 'package:peminjaman_alat_app/routes/app_routes.dart';
import 'package:peminjaman_alat_app/core/services/api_services.dart';

// import 'package:peminjaman_alat_app/features/alat/controllers/alat_controller.dart';
// import 'features/auth/login_page.dart';
// import 'package:peminjaman_alat_app/features/auth/splash_page.dart';
import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  ApiService.initialize();

  final token = GetStorage().read("auth_token");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MyApp(
        initialRoute: token != null ? AppRoutes.HOME : AppRoutes.LOGIN,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      theme: AppTheme.lightTheme,
    );
  }
}

// class MyApp extends StatelessWidget {
//   final String initialRoute;
//   const MyApp({super.key, required this.initialRoute});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthController()),
//       ],
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         initialRoute: initialRoute,
//         theme: AppTheme.lightTheme,
//         getPages: AppPages.pages,
//       ),
//     );
//   }
// }
