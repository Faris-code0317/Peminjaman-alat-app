import 'package:get/get.dart';

import 'package:peminjaman_alat_app/features/profile/model/profile_model.dart';
import 'package:peminjaman_alat_app/features/alat/model/alat_model.dart';

import 'package:peminjaman_alat_app/features/profile/services/profile_services.dart';
import 'package:peminjaman_alat_app/features/alat/services/alat_services.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var alatList = <AlatModel>[].obs;
  var userInfo = Rxn<UserModel>();
  RxInt selectedKategoriIndex = 0.obs;
  var errorMessage = ''.obs;

  // 🔥 TAMBAHKAN INI
  List<KategoriModel> get kategoriList {
    final map = <int, KategoriModel>{};

    for (var alat in alatList) {
      map[alat.kategori.idKategori] = alat.kategori;
    }

    return map.values.toList();
  }

  @override
  void onInit() {
    fetchHomeData();
    super.onInit();
  }

  Future<void> fetchHomeData() async {
    isLoading(true);

    final results = await Future.wait([
      AlatService.getAlat(),
      ProfileServices.getUser(),
    ]);

    alatList.assignAll(results[0] as List<AlatModel>);
    userInfo.value = results[1] as UserModel;

    isLoading(false);
  }
}

// Future<void> fetchHomeData() async {
//     isLoading(true);

//     final stopwatch = Stopwatch()..start();

//     final results = await Future.wait([
//       AlatService.getAlat(),
//       ProfileServices.getUser(),
//     ]);

//     stopwatch.stop();
//     print("TOTAL PARALLEL FETCH: ${stopwatch.elapsedMilliseconds}");

//     alatList.assignAll(results[0] as List<AlatModel>);
//     userInfo.value = results[1] as UserModel;

//     isLoading(false);
//   }

  // Future<void> fetchHomeData() async {
  //   isLoading(true);

  //   final totalStopwatch = Stopwatch()..start();

  //   print("START REQUEST ALAT");
  //   final s1 = Stopwatch()..start();
  //   final alatFuture = AlatService.getAlat();
  //   s1.stop();
  //   print("TIME BEFORE AWAIT ALAT: ${s1.elapsedMilliseconds}");

  //   print("START REQUEST PROFILE");
  //   final s2 = Stopwatch()..start();
  //   final profileFuture = ProfileServices.getUser();
  //   s2.stop();
  //   print("TIME BEFORE AWAIT PROFILE: ${s2.elapsedMilliseconds}");

  //   final results = await Future.wait([
  //     alatFuture,
  //     profileFuture,
  //   ]);

  //   totalStopwatch.stop();
  //   print("TOTAL PARALLEL FETCH: ${totalStopwatch.elapsedMilliseconds}");

  //   isLoading(false);
  // }