import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:peminjaman_alat_app/features/auth/controller/auth_controller.dart';
import 'package:peminjaman_alat_app/features/home/controller/home_controller.dart';
import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';
import 'package:peminjaman_alat_app/features/profile/controller/profile_controller.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

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