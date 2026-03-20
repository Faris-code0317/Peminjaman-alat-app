import 'package:dio/dio.dart';
import 'package:peminjaman_alat_app/core/constants/api_constants.dart';
import 'package:peminjaman_alat_app/core/services/api_services.dart';
import 'package:peminjaman_alat_app/core/services/storage_services.dart';

import 'package:peminjaman_alat_app/features/status/model/status_model.dart';

class StatusServices {

static final Dio _dio = ApiService.dio;
static Future<List<StatusModel>> getStatus(String status) async {

  try {

    final token = await StorageService.getToken();

    print("TOKEN: $token");

    if (token == null) {
      throw Exception("Token kosong");
    }

    final response = await _dio.get(
    "${ApiConstants.peminjamanStatus}/$status",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    print("STATUS RESPONSE TYPE: ${response.data.runtimeType}");

    final List data = response.data["data"];

    return data.map((e) => StatusModel.fromJson(e)).toList();

  } on DioException catch (e) {

    print("ERROR STATUS SERVICE: ${e.message}");
    print("ERROR STATUS RESPONSE: ${e.response}");

    throw Exception("Gagal mengambil data status");

  }
}

static Future<Response> ajukanPengembalian(int idPeminjaman) async {
  try {
    final token = await StorageService.getToken();

    if (token == null) {
      throw Exception("Token kosong");
    }

    final response = await _dio.put(
      "${ApiConstants.peminjaman}/$idPeminjaman/ajukan-pengembalian",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      ),
    );

    return response;

  } on DioException catch (e) {

    return e.response ?? Response(
      requestOptions: RequestOptions(path: ""),
      statusCode: 500,
      data: {
        "message": "Terjadi kesalahan"
      },
    );
  }
}
}