class AlatModel {
  final int idAlat;
  final String namaAlat;
  final int stok;
  final String gambar;
  final KategoriModel kategori;

  AlatModel({
    required this.idAlat,
    required this.namaAlat,
    required this.stok,
    required this.gambar,
    required this.kategori,
  });

  factory AlatModel.fromJson(Map<String, dynamic> json) {
    return AlatModel(
      idAlat: json['id_alat'],
      namaAlat: json['nama_alat'],
      stok: json['stok'],
      gambar: json['gambar'],
      kategori: KategoriModel.fromJson(json['kategori']),
    );
  }
}

class KategoriModel {
  final int idKategori;
  final String namaKategori;

  KategoriModel({
    required this.idKategori,
    required this.namaKategori,
  });

  factory KategoriModel.fromJson(Map<String, dynamic> json) {
    return KategoriModel(
      idKategori: json['id_kategori'],
      namaKategori: json['nama_kategori'],
    );
  }

  @override
  String toString() {
    return namaKategori;
  }
}
