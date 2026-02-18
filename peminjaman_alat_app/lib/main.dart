import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:peminjaman_alat_app/routes/app_pages.dart';
import 'package:peminjaman_alat_app/routes/app_routes.dart';

import 'package:peminjaman_alat_app/features/alat/alat_controller.dart';
import 'features/auth/login_page.dart';
import 'package:peminjaman_alat_app/features/auth/splash_page.dart';

void main() async {
  // ApiService.initialize();
   WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // WAJIB ADA INI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.SPLASH,
        getPages: AppPages.pages,
      ),
    );
  }
}
