import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/features/auth/register_page.dart';
import 'package:peminjaman_alat_app/features/auth/widgets/loginButtonOption.dart';
import 'package:peminjaman_alat_app/features/auth/widgets/topCardHeader.dart';

import 'package:peminjaman_alat_app/controller/auth_controller.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isVisible = false;
  bool _isObscure = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    return Scaffold(
      body: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.green1,
                AppColors.bgLight1,
                AppColors.bgLight2, 
                AppColors.bgWhite,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                topCardImage(
                  imageAsset: AppAssets.loginIcon,
                  color: AppColors.green1,
                ),

                _loginForm(auth, context),

                const SizedBox(height: 20),

                loginButtonOption(),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Belum mempunyai akun? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          color: AppColors.link,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(AuthController auth, BuildContext context) {
    return AnimatedSlide(
      offset: _isVisible ? Offset.zero : Offset(0, 0.5),
      duration: Duration(milliseconds: 1500),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: Duration(milliseconds: 1500),
        child: Container(
              width: double.infinity,
              height: 210,
              margin: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 0
                ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 2),
                  TextField(
                  controller: passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 3),
                
                if (auth.isLoading)
                const CircularProgressIndicator(color: AppColors.green1,)
                else
                  SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                          await auth.login(
                            username: usernameController.text,
                            password: passwordController.text,
                          );

                          if (auth.isLoggedIn && context.mounted) {
                            Get.offAllNamed(AppRoutes.HOME);
                          } else if (auth.errorMessage != null && context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                margin: EdgeInsets.all(20),
                                backgroundColor: AppColors.error,
                                content: Center(
                                  child: Text(
                                    auth.errorMessage!,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.bgWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              )
      ),
    );
  }
}

