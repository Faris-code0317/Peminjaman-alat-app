import 'package:peminjaman_alat_app/features/status/model/statusAlat_model.dart';

class DetailModel {
  final int idDetail;
  final int idPeminjaman;
  final int idAlat;
  final int jumlah;
  final AlatStatusModel alat;

  DetailModel({
    required this.idDetail,
    required this.idPeminjaman,
    required this.idAlat,
    required this.jumlah,
    required this.alat,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      idDetail: json["id_detail"],
      idPeminjaman: json["id_peminjaman"],
      idAlat: json["id_alat"],
      jumlah: json["jumlah"],
      alat: AlatStatusModel.fromJson(json["alat"]),
    );
  }
}