import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class userInfo_widget extends StatelessWidget {
  const userInfo_widget({
    super.key,
    required this.user,
  });

  final user;

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
                  user?.username ?? "",
                  style: TextStyle(
                    color: AppColors.grey1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Nama Lengkap :",
                ),
                Text(
                  user?.namaUser ?? "",
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