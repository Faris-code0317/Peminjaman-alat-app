import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';

import 'package:peminjaman_alat_app/features/status/model/status_model.dart';


class ajukanPengembalianButton extends StatelessWidget {
  const ajukanPengembalianButton({
    super.key,
    required this.controller,
    required this.data,
  });

  final StatusController controller;
  final StatusModel data;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
     onPressed: controller.isLoading.value ? null : () async {
    
        final confirm = await Get.dialog(
          AlertDialog(
            title: const Text("Konfirmasi"),
            content: const Text("Yakin ingin mengajukan pengembalian?"),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text(
                  "Batal",
                  style: TextStyle(
                    color: AppColors.bgWhite
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.error,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(25)
                  )
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text(
                  "Ya",
                  style: TextStyle(
                    color: AppColors.bgWhite
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.green1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(25)
                  )
                ),
              ),
            ],
          ),
        );
    
        if (confirm == true) {
          controller.ajukanPengembalian(data.idPeminjaman);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.success,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(25)
        )
      ),
      child: Text(
        "Ajukan pengembalian",
        style: TextStyle(
          color: AppColors.bgWhite
        ),
      )
    );
  }
}