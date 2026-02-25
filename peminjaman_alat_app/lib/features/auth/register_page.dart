import 'package:flutter/material.dart';
import 'package:peminjaman_alat_app/features/auth/login_page.dart';
import 'package:peminjaman_alat_app/features/auth/widgets/topCardHeader.dart';
import 'package:provider/provider.dart';
import 'controllers/auth_controller.dart';

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

  bool _isObscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffffffff),
                Color(0xFFF2F3F7), 
                Color(0xFFEDEFF5), 
                Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                topCardImage(imageAsset: AssetImage("assets/icons/2.png"), color: Color.fromRGBO(167, 193, 231, 1),),

                Container(
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
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(167, 193, 231, 1),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.person),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(167, 193, 231, 1),
                              width: 2,
                            ),
                          ),
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
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(167, 193, 231, 1),
                              width: 2,
                            ),
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
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(167, 193, 231, 1),
                              width: 2,
                            ),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(167, 193, 231, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(15)
                            )
                          ),
                          onPressed: () async {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(15)
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffA13842),
                                  content: Center(
                                    child: Text(
                                      "Password tidak sama",
                                      style: TextStyle(color: Colors.white),
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadiusGeometry.circular(15)
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.all(20),
                                  backgroundColor: const Color.fromARGB(255, 65, 199, 78),
                                  content:
                                   Center(
                                    child: Text(
                                      "Registrasi berhasil, silakan login",
                                      style: TextStyle(color: Colors.white),
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

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
                            color: Colors.blue,
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
}


                //TextField(
                //   controller: namaController,
                //   decoration: const InputDecoration(labelText: "Nama Lengkap"),
                // ),
                // TextField(
                //   controller: usernameController,
                //   decoration: const InputDecoration(labelText: "Username"),
                // ),
                // TextField(
                //   controller: passwordController,
                //   decoration: const InputDecoration(labelText: "Password"),
                //   obscureText: true,
                // ),
                // TextField(
                //   controller: confirmPasswordController,
                //   decoration:
                //       const InputDecoration(labelText: "Confirm Password"),
                //   obscureText: true,
                // ),