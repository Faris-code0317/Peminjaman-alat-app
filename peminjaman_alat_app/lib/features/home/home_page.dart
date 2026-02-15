import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/auth_controller.dart';
import '../auth/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();

              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginPage()),
                  (route) => false,
                );
              }
            },
          )
        ],
      ),
      body: const Center(
        child: Text("Login Success - Home Page"),
      ),
    );
  }
}
