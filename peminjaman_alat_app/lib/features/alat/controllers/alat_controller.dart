import 'package:get/get.dart';
import 'package:peminjaman_alat_app/models/alat_model.dart';
import '../alat_services.dart';

class AlatController extends GetxController {
  var isLoading = true.obs;
  var alatList = <AlatModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      final result = await AlatService.getAlat();
      alatList.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
