import 'package:get/get.dart';
import 'package:peminjaman_alat_app/models/alat_model.dart';
import 'package:peminjaman_alat_app/services/alat_services.dart';

class AlatController extends GetxController {
  var isLoading = true.obs;
  var alatList = <AlatModel>[].obs;
  var errorMessage = ''.obs;

  //start
   final stopwatch = Stopwatch()..start();
   //end

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

 void fetchData() async {
    try {
      isLoading(true);

      final stopwatch = Stopwatch()..start();

      final data = await AlatService.getAlat();

      stopwatch.stop();
      print("ALAT FETCH: ${stopwatch.elapsedMilliseconds} ms");

      alatList.assignAll(data);

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}

