import 'package:get/get.dart';
import 'package:peminjaman_alat_app/features/profile/model/profile_model.dart';
import 'package:peminjaman_alat_app/features/profile/services/profile_services.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var userInfo = Rxn<UserModel>();
  var errorMessage = ''.obs;

    //start
   final stopwatch = Stopwatch()..start();
   //end

  @override
  void onInit() {
    fetchAlat();
    super.onInit();
  }

  void fetchAlat() async {
    try {
      isLoading(true);

      final stopwatch = Stopwatch()..start();

      final dataUser = await ProfileServices.getUser();

      stopwatch.stop();
      print("PROFILE FETCH: ${stopwatch.elapsedMilliseconds} ms");

      userInfo.value = dataUser;

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
