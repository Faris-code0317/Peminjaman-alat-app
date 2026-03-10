import 'package:peminjaman_alat_app/features/status/model/statusKategori_model.dart';

class AlatStatusModel {
  final int idAlat;
  final String namaAlat;
  final int stok;
  final String gambar;
  final KategoriStatusModel kategori;

  AlatStatusModel({
    required this.idAlat,
    required this.namaAlat,
    required this.stok,
    required this.gambar,
    required this.kategori,
  });

  factory AlatStatusModel.fromJson(Map<String, dynamic> json) {
    return AlatStatusModel(
      idAlat: json["id_alat"],
      namaAlat: json["nama_alat"],
      stok: json["stok"],
      gambar: json["gambar"],
      kategori: KategoriStatusModel.fromJson(json["kategori"]),
    );
  }
}