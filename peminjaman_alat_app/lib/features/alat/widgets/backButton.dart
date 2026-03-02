import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class backButton_widget extends StatelessWidget {
  const backButton_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: (){
          Get.offAllNamed(AppRoutes.HOME);
        }, 
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.green1,
        )
      ),
    );
  }
}