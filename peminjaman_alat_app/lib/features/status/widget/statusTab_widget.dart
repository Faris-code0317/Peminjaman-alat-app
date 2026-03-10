import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';

class StatusTabWidget extends StatelessWidget {
  const StatusTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StatusController>();

    Color getStatusColor(String status) {
      switch (status) {
        case "menunggu":
          return AppColors.warning;
        case "dipinjam":
          return AppColors.success;
        case "pengembalian":
          return AppColors.link;
        case "dikembalikan":
          return AppColors.green1;
        case "ditolak":
          return AppColors.error;
        default:
          return AppColors.grey1;
      }
    }

   return Obx(() {

      final selectedIndex = controller.selectedStatusIndex.value;

      return Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: SizedBox(
          height: 45,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.statusTab.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
        
            itemBuilder: (context, index) {
        
              bool isActive = selectedIndex == index;
        
              return GestureDetector(
                onTap: () {
                  controller.changeTab(index);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                    color: isActive
                        ? getStatusColor(controller.statusTab[index])
                        : AppColors.grey2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    controller.statusTab[index],
                    style: TextStyle(
                      color: AppColors.bgWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}