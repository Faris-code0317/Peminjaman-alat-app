import 'package:get/get.dart';
import 'package:peminjaman_alat_app/models/alat_model.dart';
import 'package:peminjaman_alat_app/features/alat/alat_services.dart';
class HomeController extends GetxController {
  var isLoading = true.obs;
  var alatList = <AlatModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchAlat();
    super.onInit();
  }

  void fetchAlat() async {
    try {
      isLoading(true);

      final data = await AlatService.getAlat();
      alatList.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
