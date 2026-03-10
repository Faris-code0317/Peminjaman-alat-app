import 'package:dio/dio.dart';
import 'package:peminjaman_alat_app/core/constants/api_constants.dart';
import 'package:peminjaman_alat_app/core/services/storage_services.dart';
import 'package:peminjaman_alat_app/features/status/model/status_model.dart';

class StatusServices {

  static final Dio _dio = Dio();

  static Future<List<StatusModel>> getStatus(String status) async {

    try {

      final token = await StorageService.getToken();

      final response = await _dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.peminjamanStatus}/$status",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

      final List data = response.data["data"];

      return data.map((e) => StatusModel.fromJson(e)).toList();

    } on DioException catch (e) {

      print("ERROR STATUS SERVICE: ${e.response}");

      throw Exception("Gagal mengambil data status");

    }
  }
}