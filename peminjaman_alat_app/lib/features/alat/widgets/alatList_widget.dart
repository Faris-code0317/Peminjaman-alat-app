import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/controller/alat_controller.dart';
class AlatListWidget extends StatelessWidget {
  const AlatListWidget({
    super.key,
    required this.alatController,
  });

  final AlatController alatController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
          if (alatController.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.green1,));
          }

          final alatList = alatController.filteredAlatList;

          if(alatList.isEmpty){
            return const Center(child: Text('Tidak ada data alat'));
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

              return Container(
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
                margin: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(alat.gambar,
                            height: 120),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "${alat.stok} Stok tersisa",
                        style: TextStyle(
                          fontSize: 12,
                          color: alat.stok > 5
                              ? AppColors.green1
                              : AppColors.error,
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
              );
            },
          );
        }
      );
  }
}