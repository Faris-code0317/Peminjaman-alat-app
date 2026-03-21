import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/status/model/status_model.dart';
import 'package:peminjaman_alat_app/features/status/services/status_services.dart';

class StatusController extends GetxController {

  var isLoading = false.obs;
  var isFirstLoad = true.obs;
  var statusList = <StatusModel>[].obs;

  RxInt selectedStatusIndex = 0.obs;

  final List<String> statusTab = [
    "menunggu",
    "dipinjam",
    "pengembalian",
    "dikembalikan",
    "ditolak"
  ];

  @override
  void onInit() {
    super.onInit();

    Future.microtask((){
       fetchStatus(statusTab[0]);
    });
  }

  Future<void> fetchStatus(String status) async {
    try {

      isLoading.value = true;

      print("FETCH STATUS: $status");

      final result = await StatusServices.getStatus(status);

      print("DATA STATUS: ${result.length}");

      statusList.assignAll(result);

    } catch (e) {

      print("ERROR CONTROLLER STATUS: $e");

      statusList.clear();

    } finally {

      isLoading.value = false;
      isFirstLoad.value = false;

    }
  }

  void changeTab(int index) async {

    if (selectedStatusIndex.value == index) return;

    selectedStatusIndex.value = index;

    await fetchStatus(statusTab[index]);
  }

  Future<void> ajukanPengembalian(int idPeminjaman) async {
    try {

      isLoading.value = true;

      final response = await StatusServices.ajukanPengembalian(idPeminjaman);

      final data = response.data;

      if (response.statusCode == 200) {

        Get.snackbar(
          "✅ Berhasil",
          data["message"],
          margin: EdgeInsets.all(15)
        );

        await fetchStatus(statusTab[selectedStatusIndex.value]);

      } else {

        Get.snackbar(
          "🚫 Gagal",
          data["message"] ?? "Terjadi kesalahan",
          margin: EdgeInsets.all(15)
        );

      }

    } catch (e) {

      Get.snackbar(
        "⚠️ Error",
        "Terjadi kesalahan",
        margin: EdgeInsets.all(15)
      );

    } finally {

      isLoading.value = false;

    }
  }
}