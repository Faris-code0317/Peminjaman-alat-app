import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/profile/controller/profile_controller.dart';
import 'package:peminjaman_alat_app/features/auth/controller/auth_controller.dart';
import 'package:peminjaman_alat_app/features/home/controller/home_controller.dart';
import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';


import 'package:peminjaman_alat_app/routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> 
  with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, 
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              userInfo_widget(),

              SizedBox(height: 20),

              syaratKetentuanButton_widget(),

              SizedBox(height: 5),

              logoutButton_widget()

              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     'INPUT QUANTITY',
              //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              //   ),
              // ),
              // const Padding(
              //   padding: EdgeInsets.all(14.0),
              //   child: Text(
              //     'by: pmatatias.dev',
              //     style: TextStyle(fontSize: 14, color: Colors.blue),
              //   ),
              // ),
              // Center(
              //   child: 
              //   IconButton(
              //    onPressed: () async {
              //       final auth = context.read<AuthController>();
        
              //       await auth.logout();
        
              //       await Future.delayed(const Duration(milliseconds: 100));
        
              //       Get.delete<HomeController>();
              //       Get.delete<StatusController>();
              //       Get.delete<ProfileController>();
        
              //       Get.offAllNamed(AppRoutes.LOGIN);
        
              //     },
              //     icon: const Icon(Icons.logout),
              //   ),
              // )

              // IconButton(
              //     onPressed: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const Example1(),
              //         )),
              //     icon: const Icon(Icons.exit_to_app))
            ],
          ),
        ),
      ),
    );
  }
}

class logoutButton_widget extends StatelessWidget {
  const logoutButton_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final auth = context.read<AuthController>();
        
        await auth.logout();
        await Future.delayed(const Duration(milliseconds: 100));

        Get.delete<HomeController>();
        Get.delete<StatusController>();
        Get.delete<ProfileController>();
        Get.offAllNamed(AppRoutes.LOGIN);

      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: AppColors.black1.withOpacity(0.15),
                blurRadius: 10,
                offset: Offset(0, 4)
              )
            ]
          ),
          child: const Padding(
            padding: EdgeInsetsGeometry.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Keluar Dari Akun",
                ),
                Icon(
                  Icons.login_outlined
                )
              ],
            ),
          ),
        ),
    );
  }
}

class syaratKetentuanButton_widget extends StatelessWidget {
  const syaratKetentuanButton_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.black1.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4)
          )
        ]
      ),
      child: const Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Syarat & Ketentuan Peminjam",
            ),
            Icon(
              Icons.keyboard_arrow_right
            )
          ],
        ),
      ),
    );
  }
}

class userInfo_widget extends StatelessWidget {
  const userInfo_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: AppColors.black1.withOpacity(0.15),
            blurRadius: 10,
            offset: Offset(0, 4)
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username :",
                ),
                Text(
                  "muhith123",
                  style: TextStyle(
                    color: AppColors.grey1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Nama Lengkap :",
                ),
                Text(
                  "Abdul Muhith Faris Musyaffa",
                  style: TextStyle(
                    color: AppColors.grey1,
                  ),
                ),
              ],
            ),
    
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppColors.green1,
                borderRadius: BorderRadius.circular(35 / 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black1.withOpacity(0.10),
                    blurRadius: 10,
                    offset: Offset(0, 4)
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.edit,
                  color: AppColors.bgWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}