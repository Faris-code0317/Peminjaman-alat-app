import 'package:get/get.dart';
import 'package:peminjaman_alat_app/controller/alat_controller.dart';

class AlatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlatController>(() => AlatController());
  }
}