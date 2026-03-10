import 'package:dio/dio.dart';
import 'package:peminjaman_alat_app/core/constants/api_constants.dart';
import 'package:peminjaman_alat_app/core/services/api_services.dart';
import 'package:peminjaman_alat_app/core/services/storage_services.dart';

import 'package:peminjaman_alat_app/features/profile/model/profile_model.dart';


class ProfileServices {

  static const String baseUrl = ApiConstants.baseUrl;

  static Future<UserModel> getUser() async {
  try {
    final token = await StorageService.getToken();

    if (token == null) {
      throw Exception("Token kosong");
    }

    final response = await ApiService.dio.get(
      ApiConstants.me,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    final data = response.data['data'];

    return UserModel.fromJson(data);

  } on DioException catch (e) {
    throw Exception(e.response?.data.toString());
  }
}

}