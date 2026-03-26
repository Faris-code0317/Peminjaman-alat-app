import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/utils/helpers.dart';

import 'package:peminjaman_alat_app/features/alat/page/alatDetail_page.dart';

import 'package:peminjaman_alat_app/features/alat/controller/alat_controller.dart';
class AlatListWidget extends StatelessWidget {
  const AlatListWidget({
    super.key,
    required this.alatController,
  });

  final AlatController alatController;

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
          if (alatController.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.green1,));
          }

          final alatList = alatController.filteredAlatList;

          if(alatList.isEmpty){
            return Center(child: _EmptyWidget());
          }

          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              mainAxisExtent: 250
            ),
            itemCount: alatList.length,
            itemBuilder: (context, index) {
              final alat = alatList[index];

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
                  // Get.to(() => alatDetail_page(
                  //   gambar: alat.gambar,
                  //   stok: alat.stok,
                  //   kategori: alat.kategori.namaKategori,
                  //   namaAlat: alat.namaAlat,
                  // ));
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
                          "${alat.stok} Stok tersisa",
                          style: TextStyle(
                            fontSize: 12,
                            color: getStokColor(alat.stok),
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
        }
      );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image(
          image: AppAssets.notFoundIcon,
          width: 260,
        ),

        const SizedBox(height: 10),

        const Text(
          "⛔ Maaf, data alat belum tersedia",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "Admin belum menambahkan data alat untuk dipinjam",
          style: TextStyle(
            color: AppColors.grey1,
            fontSize: 13,
          ),
        ),

      ],
    );
  }
}