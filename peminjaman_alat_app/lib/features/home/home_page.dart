import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/home/controllers/home_controller.dart';
import 'package:peminjaman_alat_app/core/services/auth_services.dart';
import '../../../routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.logout();
              Get.offAllNamed(AppRoutes.LOGIN);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(controller.errorMessage.value),
          );
        }

        // return ListView.builder(
        //   itemCount: controller.alatList.length,
        //   itemBuilder: (context, index) {
        //     final alat = controller.alatList[index];

        //     return Card(
        //       margin: const EdgeInsets.all(10),
        //       child: ListTile(
        //         title: Text(alat.namaAlat),
        //         subtitle: Text(
        //             "Kategori: ${alat.kategori}\nStok: ${alat.stok}"),
        //       ),
        //     );
        //   },
        // );
        return ListView.builder(
          itemCount: controller.alatList.length,
          itemBuilder: (context, index) {
            final alat = controller.alatList[index];
            return Container(
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
      }),
    );
  }
}
