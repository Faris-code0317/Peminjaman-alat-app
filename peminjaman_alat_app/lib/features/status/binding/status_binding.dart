import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';

class StatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusController>(() => StatusController());
  }
}