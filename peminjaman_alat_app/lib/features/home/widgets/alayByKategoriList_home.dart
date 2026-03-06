import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/controller/home_controller.dart';
// import 'package:peminjaman_alat_app/controller/alat_controller.dart';

import 'package:peminjaman_alat_app/features/alat/alatDetail_page.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class KategoriList extends StatelessWidget {
  const KategoriList({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

    Color getStokColor(int stok) {
  if (stok >= 11) {
    return AppColors.success;
  } else if (stok <= 5) {
    return AppColors.error;
  } else {
    return AppColors.warning;
  }
}

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final kategoriList = homeController.kategoriList;

      if (kategoriList.isEmpty) {
        return const SizedBox();
      }

      final selectedIndex =
          homeController.selectedKategoriIndex.value;

      final selectedKategori =
          kategoriList[selectedIndex];

      final filteredList = homeController.alatList
          .where((alat) =>
              alat.kategori.idKategori ==
              selectedKategori.idKategori)
          .toList();

      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          mainAxisExtent: 250
        ),      
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final alat = filteredList[index];

          return InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => alatDetail_page(
                    gambar: alat.gambar,
                    stok: alat.stok,
                    kategori: alat.kategori.namaKategori,
                    namaAlat: alat.namaAlat,
                    // alatController: Get.find<AlatController>(),
                  ),
                )
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.circular(15),
                 boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                   ),
                 ]
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.network(
                          alat.gambar,
                          height: 120
                        ),
                      ),
                    SizedBox(height: 15,),
                    Text(
                      "${alat.stok} Stok tersisa",
                      style: TextStyle(
                        fontSize: 12,
                        color: getStokColor(alat.stok)
                      ),
                    ),
                    Text(
                      "${alat.kategori}",
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontSize: 12
                      ),
                    ),
                    Text(
                      alat.namaAlat,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black1,
                        fontSize: 15
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}