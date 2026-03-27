import 'package:get/get.dart';

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