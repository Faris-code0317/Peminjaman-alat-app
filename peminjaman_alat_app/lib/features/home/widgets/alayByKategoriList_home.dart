import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjaman_alat_app/core/utils/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:peminjaman_alat_app/features/home/controller/home_controller.dart';
// import 'package:peminjaman_alat_app/controller/alat_controller.dart';

import 'package:peminjaman_alat_app/features/alat/page/alatDetail_page.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/widgets/empty_widget.dart';

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
        return EmptyWidget(
          title: homeController.emptyTitle,
          description: homeController.emptyDescription,
        );
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
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                    idAlat: alat.idAlat,
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
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                   ),
                 ]
              ),
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 15),
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                          imageUrl: getImageUrl(alat.gambar),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,

                          placeholder: (context, url) => Container(
                            width: 70,
                            height: 70,
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(strokeWidth: 2),
                          ),

                          errorWidget: (context, url, error) => Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported),
                          ),
                        )
                      ),
                    SizedBox(height: 35,),
                    Text(
                      "${alat.stok} Stok tersedia",
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