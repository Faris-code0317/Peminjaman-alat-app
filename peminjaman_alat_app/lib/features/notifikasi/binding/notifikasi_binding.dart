import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/notifikasi/controller/notifikasi_controller.dart';

class NotifikasiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifikasiController>(() => NotifikasiController());
  }
}