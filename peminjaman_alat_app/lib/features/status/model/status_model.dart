import 'package:peminjaman_alat_app/features/status/model/statusDetail_model.dart';

class StatusModel {
  final int idPeminjaman;
  final int idUser;
  final String status;
  final String? tanggalKembali;
  final String tanggalPinjam;
  final String? tanggalDisetujui;
  final String? tanggalPengajuanPengembalian;
  final String? alasanDitolak;
  final List<DetailModel> detail;

  StatusModel({
    required this.idPeminjaman,
    required this.idUser,
    required this.tanggalPinjam,
    required this.status,
    this.tanggalKembali,
    this.tanggalDisetujui,
    this.tanggalPengajuanPengembalian,
    this.alasanDitolak,
    required this.detail,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      idPeminjaman: json["id_peminjaman"],
      idUser: json["id_user"],
      tanggalPinjam: json["tanggal_pinjam"],
      status: json["status"],
      tanggalKembali: json["tanggal_kembali"],
      tanggalDisetujui: json["tanggal_disetujui"],
      tanggalPengajuanPengembalian: json["tanggal_pengajuan_pengembalian"],
      alasanDitolak: json["alasan_ditolak"],
      detail: List<DetailModel>.from(
        json["detail"].map((x) => DetailModel.fromJson(x)),
      ),
    );
  }
}