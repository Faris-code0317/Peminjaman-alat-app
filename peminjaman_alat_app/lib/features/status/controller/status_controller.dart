import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/status/model/status_model.dart';
import 'package:peminjaman_alat_app/features/status/services/status_services.dart';

class StatusController extends GetxController {

  var isLoading = false.obs;
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
    fetchStatus(statusTab[0]);
  }

  Future<void> fetchStatus(String status) async {

    try {

      isLoading(true);

      final result = await StatusServices.getStatus(status);

      statusList.assignAll(result);

    } catch (e) {

      print("ERROR CONTROLLER STATUS: $e");

      statusList.clear();

    } finally {

      isLoading(false);

    }
  }

  void changeTab(int index) {

    selectedStatusIndex.value = index;

    fetchStatus(statusTab[index]);

  }
}