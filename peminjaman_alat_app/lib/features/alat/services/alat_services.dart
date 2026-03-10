import 'package:dio/dio.dart';
import 'package:peminjaman_alat_app/core/constants/api_constants.dart';
import 'package:peminjaman_alat_app/core/services/api_services.dart';
import 'package:peminjaman_alat_app/core/services/storage_services.dart';

import 'package:peminjaman_alat_app/features/alat/model/alat_model.dart';

class AlatService {

  static const String baseUrl = ApiConstants.baseUrl;

  static Future<List<AlatModel>> getAlat() async {
  try {
    final stopwatch = Stopwatch()..start();

    final token = await StorageService.getToken();

    if (token == null) {
      throw Exception("Token kosong");
    }

    final response = await ApiService.dio.get(
      ApiConstants.alat,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    stopwatch.stop();

    final List data = response.data['data'];

    final raw = response.toString();

    print("RESPONSE LENGTH: ${raw.length}");
    print("REQUEST TIME: ${stopwatch.elapsedMilliseconds} ms");

    return data.map((e) => AlatModel.fromJson(e)).toList();

  } on DioException catch (e) {
    print("DIO ERROR: ${e.response?.statusCode}");
    print("DIO ERROR DATA: ${e.response?.data}");
    throw Exception(e.response?.data.toString());
  }
}

}
