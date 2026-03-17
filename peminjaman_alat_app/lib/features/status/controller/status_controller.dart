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
}