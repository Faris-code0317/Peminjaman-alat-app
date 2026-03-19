import 'package:dio/dio.dart';
import 'package:peminjaman_alat_app/core/services/api_services.dart';
import 'package:peminjaman_alat_app/core/constants/api_constants.dart';

class PeminjamanService {
  static Future<Response> ajukanPeminjaman({
    required int idAlat,
    required int jumlah,
  }) async {
    try {
      final response = await ApiService.dio.post(
        ApiConstants.peminjaman,
        data: {
          "alat": [
            {
              "id_alat": idAlat,
              "jumlah": jumlah
            }
          ]
        },
      );

      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}