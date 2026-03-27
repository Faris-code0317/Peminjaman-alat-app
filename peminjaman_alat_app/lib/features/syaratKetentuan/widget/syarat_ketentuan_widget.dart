import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class SyaratKetentuanWidget extends StatelessWidget {
  const SyaratKetentuanWidget({super.key});

  Widget bulletItem(String text) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Text(
        "•",
        style: TextStyle(fontSize: 20),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: AppColors.black1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Center(
          child: Text(
            "📄 Syarat & Ketentuan Peminjaman Alat",
            style: TextStyle(
              color: AppColors.black1,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "📌 Syarat Peminjam",
          style: TextStyle(
            color: AppColors.black1,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 8),

        bulletItem("Peminjam merupakan siswa atau pihak yang memiliki izin untuk meminjam alat."),
        bulletItem("Peminjam hanya bisa mengajukan peminjaman alat yang tersedia"),
        bulletItem("Peminjam harus disetujui oleh petugas"),
        bulletItem("Peminjam wajib mengisi jumlah alat yang ingin dipinjam sesuai dengan kebutuhan."),
        bulletItem("Jumlah alat yang dipinjam tidak boleh melebihi stok yang tersedia."),

        const SizedBox(height: 20),

        Text(
          "⚠ Ketentuan Peminjaman",
          style: TextStyle(
            color: AppColors.black1,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 8),

        bulletItem("Peminjam tidak diperbolehkan memindahtangankan alat kepada orang lain."),
        bulletItem("Alat yang dipinjam harus dikembalikan dalam kondisi yang sama seperti saat pertama kali dipinjam."),
        bulletItem("Peminjam bertanggung jawab penuh atas alat selama masa peminjaman."),
        bulletItem("Apabila alat mengalami kerusakan atau kehilangan saat dipinjam, maka peminjam akan dikenakan sanksi atau denda."),

        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: const Text("•", style: TextStyle(fontSize: 20)),
          title: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 15,
                color: AppColors.black1,
              ),
              children: [
                const TextSpan(text: "Besaran denda yang dikenakan akan "),
                TextSpan(
                  text: "disesuaikan dengan tingkat kerusakan atau kehilangan alat.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}