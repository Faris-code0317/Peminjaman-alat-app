import 'package:flutter/material.dart';
import 'package:peminjaman_alat_app/features/auth/login_page.dart';
import 'package:peminjaman_alat_app/features/auth/widgets/topCardHeader.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';
import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaController = TextEditingController();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool _isObscure = true;
  bool _isVisible = false;
  bool _isObscureConfirm = true;

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
                AppColors.primaryRegister,
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
                  imageAsset: AppAssets.regisIcon, 
                  color: AppColors.primaryRegister,
                ),

                _registerForm(auth),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Sudah mempunyai akun?? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Masuk",
                          style: TextStyle(
                            color: AppColors.link,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerForm(AuthController auth) {
    return AnimatedSlide(
      offset: _isVisible ? Offset.zero : Offset(0, 0.5),
      duration: Duration(milliseconds: 1500),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: Duration(milliseconds: 1500),
        child: Container(
            width: double.infinity,
            height: 350,
            margin: EdgeInsets.only(
              top: 0,
              left: 15,
              right: 15,
              bottom: 0
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                TextField(
                  controller: namaController,
                  decoration: InputDecoration(
                    hintText: "Nama Lengkap",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: "Username",
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

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

              TextField(
                controller: confirmPasswordController,
                obscureText: _isObscureConfirm,
                decoration: InputDecoration(
                  hintText: "Konfirmasi Password",
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureConfirm ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureConfirm = !_isObscureConfirm;
                      });
                    },
                  ),
                ),
              ),

              if (auth.isLoading)
                const CircularProgressIndicator()
              else
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            margin: EdgeInsets.all(20),
                            backgroundColor: AppColors.error,
                            content: Center(
                              child: Text(
                                "Password tidak sama",
                              )
                            ),
                          ),
                        );
                        return;
                      }

                      bool success = await auth.register(
                        namaLengkap: namaController.text,
                        username: usernameController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );

                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            margin: EdgeInsets.all(20),
                            backgroundColor: AppColors.success,
                            content: Center(
                              child: Text(
                                "Registrasi berhasil, silakan login",
                              )
                            ),
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.bgWhite,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
