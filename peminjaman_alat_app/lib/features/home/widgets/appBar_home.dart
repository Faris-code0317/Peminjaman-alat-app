import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class appBar_widget extends StatelessWidget {
  const appBar_widget({
    super.key,
    required this.user,
  });

  final  user;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 60,
      // color: AppColors.green1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat datang",
                  style: TextStyle(
                    color: AppColors.grey1,
                    fontSize: 11
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.person, color: AppColors.green1,),
                    SizedBox(width: 2),
                    Text(
                      user?.namaUser ?? "",
                      style: TextStyle(
                        color: AppColors.black1,
                        fontSize: 14
                      ),
                    ),
                  ],
                )
              ],
            ),

            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.circular(35 / 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black1.withOpacity(0.10),
                    blurRadius: 10,
                    offset: Offset(0, 4)
                  )
                ]
              ),
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.notifications, 
                  color: AppColors.green1,
                ),
              )
            ),

          ],
        ),
      ),
    );
  }
}