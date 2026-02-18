import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'alat_controller.dart';

class AlatPage extends StatelessWidget {
  AlatPage({super.key});

  final AlatController controller = Get.put(AlatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Alat"),
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
