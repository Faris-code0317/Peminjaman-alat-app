import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/api_services.dart';
import 'features/auth/auth_controller.dart';
import 'features/auth/login_page.dart';
import 'package:peminjaman_alat_app/features/auth/splash_page.dart';

void main() {
  ApiService.initialize();
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
      ),
    );
  }
}
