import 'package:get/get.dart';

import 'package:peminjaman_alat_app/features/profile/model/profile_model.dart';
import 'package:peminjaman_alat_app/features/alat/model/alat_model.dart';

import 'package:peminjaman_alat_app/features/profile/services/profile_services.dart';
import 'package:peminjaman_alat_app/features/alat/services/alat_services.dart';

class NotifikasiController extends GetxController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifikasi();
  }

  Future<void> fetchNotifikasi() async {
    isLoading(true);
    await Future.delayed(Duration(seconds: 3));
    isLoading(false);
  }
}