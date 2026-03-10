class UserModel {
  final int idUser;
  final String namaUser;
  final String username;

  UserModel({
    required this.idUser,
    required this.namaUser,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      idUser: json['id_user'],
      namaUser: json['nama_lengkap'],
      username: json['username'],
    );
  }
}