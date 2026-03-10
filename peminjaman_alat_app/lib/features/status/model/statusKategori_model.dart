class KategoriStatusModel {
  final int idKategori;
  final String namaKategori;

  KategoriStatusModel({
    required this.idKategori,
    required this.namaKategori,
  });

  factory KategoriStatusModel.fromJson(Map<String, dynamic> json) {
    return KategoriStatusModel(
      idKategori: json["id_kategori"],
      namaKategori: json["nama_kategori"],
    );
  }
}