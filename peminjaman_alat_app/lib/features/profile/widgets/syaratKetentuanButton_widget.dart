import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/syaratKetentuan/page/syarat_ketentuan_page.dart';

class syaratKetentuanButton_widget extends StatelessWidget {
  const syaratKetentuanButton_widget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => const SyaratKetentuanPage());
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
                "Syarat & Ketentuan Peminjam",
              ),
              Icon(
                Icons.keyboard_arrow_right
              )
            ],
          ),
        ),
      ),
    );
  }
}