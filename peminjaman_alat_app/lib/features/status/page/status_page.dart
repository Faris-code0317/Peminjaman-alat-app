import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';
import 'package:peminjaman_alat_app/features/status/widget/statusTab_widget.dart';
import 'package:peminjaman_alat_app/features/status/widget/statusList_widget.dart';

class StatusPage extends StatelessWidget {
  StatusPage({super.key});

  final StatusController controller = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Column(
        children: [
    
          const SizedBox(height: 15),
    
          /// TAB STATUS
          StatusTabWidget(),
    
          const SizedBox(height: 10),
    
          /// LIST STATUS
          Expanded(
            child: Obx(() {
    
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
    
              if (controller.statusList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                
                    Image(
                      image: AppAssets.notFoundIcon,
                      width: 260,
                    ),
                
                    const SizedBox(height: 10),
                
                    const Text(
                      "Data tidak ditemukan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                
                    const SizedBox(height: 4),
                
                    Text(
                      "Belum ada peminjaman pada status ini",
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontSize: 13,
                      ),
                    ),
                
                  ],
                );
              }
    
              return StatusListWidget();
    
            }),
          ),
        ],
      ),
    );
  }
}