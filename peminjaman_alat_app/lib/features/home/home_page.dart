import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/home/controllers/home_controller.dart';
// import 'package:peminjaman_alat_app/core/services/auth_services.dart';
// import '../../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  final ScrollController scrollController;
  HomePage({super.key, required this.scrollController});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }
        return ListView.builder(
          controller: scrollController,
          itemCount: controller.alatList.length,
          itemBuilder: (context, index) {
            final alat = controller.alatList[index];
            return Container(
              margin: EdgeInsets.only(bottom: 20, top: 10),
              child: Column(
                children: [
                  Image.network(
                  alat.gambar,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                  Text(alat.namaAlat),
                  Text("Kategori: ${alat.kategori.namaKategori}"),
                  Text("Stok : ${alat.stok}")
                ],
              ),
            );
          },
        );
      });
  }
}
