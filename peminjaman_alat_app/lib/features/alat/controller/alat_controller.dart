import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/alat/model/alat_model.dart';
import 'package:peminjaman_alat_app/features/alat/services/alat_services.dart';

class AlatController extends GetxController {
  var isLoading = true.obs;
  var alatList = <AlatModel>[].obs;
  var errorMessage = ''.obs;
  var selectedKategori = <String>[].obs;
  var filteredAlatList = <AlatModel>[].obs;
  final String emptyTitle = "😕 Maaf, belum ada data alat yang tersedia";
  final String emptyDescription = "Admin belum menambahkan data alat untuk dipinjam";

  List<KategoriModel> get kategoriList {
    final map = <int, KategoriModel>{};

    for (var alat in alatList) {
      map[alat.kategori.idKategori] = alat.kategori;
    }

    return map.values.toList();
  }

  //start
   final stopwatch = Stopwatch()..start();
   //end

  @override
  void onInit() {
    fetchData();
    ever(alatList, (_) => updateFilteredList());
    ever(selectedKategori, (_) => updateFilteredList());
    super.onInit();
  }

  void updateFilteredList() {
    if (selectedKategori.isEmpty) {
      filteredAlatList.assignAll(alatList);
    } else {
      filteredAlatList.assignAll(alatList.where((alat) => selectedKategori.contains(alat.kategori.namaKategori)));
    }
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

