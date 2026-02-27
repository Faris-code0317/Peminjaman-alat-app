import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/controller/home_controller.dart';

import 'package:peminjaman_alat_app/features/home/widgets/appBar_home.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/services/auth_services.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.scrollController});
    
  final ScrollController scrollController;
  final HomeController Homecontroller = Get.find();
  // final AlatController Alatcontroller = Get.find();
  // final ProfileController Profilecontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
          final user = Homecontroller.userInfo.value;
          if (Homecontroller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
      
          if (Homecontroller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(Homecontroller.errorMessage.value),
            );
          }
          return SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                appBar_widget(user: user),

                IconButton(
                  onPressed: () async {
                    await AuthService.logout();
                    Get.offAllNamed(AppRoutes.LOGIN);
                  },
                  icon: const Icon(Icons.logout),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: Homecontroller.alatList.length,
                  itemBuilder: (context, index) {
                    final alat = Homecontroller.alatList[index];
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
                ),
              ],
            ),
          );
        }
      );
  }
}
