import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

// import 'package:peminjaman_alat_app/features/home/home_page.dart';

import 'package:peminjaman_alat_app/controller/home_controller.dart';

class KategoriTab extends StatelessWidget {
  KategoriTab({super.key});

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final kategoriList = controller.kategoriList;

      if (kategoriList.isEmpty) return const SizedBox();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: DefaultTabController(
          length: kategoriList.length,
          child: ButtonsTabBar(
            decoration: BoxDecoration(
              color: AppColors.green1,
               boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                 ),
               ]
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25),
            buttonMargin: EdgeInsets.only(right: 15),
            unselectedBackgroundColor: AppColors.bgWhite,
            unselectedLabelStyle: TextStyle(color: AppColors.green1),
            labelStyle: const TextStyle(
              color: AppColors.bgWhite,
              fontWeight: FontWeight.bold,
            ),
            tabs: kategoriList
                .map((kategori) =>
                    Tab(text: kategori.namaKategori))
                .toList(),
            onTap: (index) {
              controller.selectedKategoriIndex.value =
                  index;
            },
          ),
        ),
      );
    });
  }
}

