import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

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