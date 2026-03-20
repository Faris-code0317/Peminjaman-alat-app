import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/features/alat/services/peminjaman_services.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class peminjamanBottomSheet_widget extends StatefulWidget {
  const peminjamanBottomSheet_widget({
    super.key,
    required this.id_alat,
    required this.stok,
  });

  final int id_alat;
  final int stok;

  @override
  State<peminjamanBottomSheet_widget> createState() => _peminjamanBottomSheet_widgetState();
}

class _peminjamanBottomSheet_widgetState extends State<peminjamanBottomSheet_widget> {

  bool isAgree = false;

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgWhite,
        borderRadius: BorderRadius.circular(25),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          child: Column(
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

              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: isAgree,
                    activeColor: AppColors.green1,
                    onChanged: (value) {
                      setState(() {
                        isAgree = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      "Saya menyetujui syarat dan ketentuan peminjaman alat",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black1,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              inputStokDanButtonAjukan(
                id_alat: widget.id_alat,
                widget: widget, 
                isAgree: isAgree
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class inputStokDanButtonAjukan extends StatefulWidget {
  const inputStokDanButtonAjukan({
    super.key,
    required this.id_alat,
    required this.widget,
    required this.isAgree,
  });

  final int id_alat;
  final peminjamanBottomSheet_widget widget;
  final bool isAgree;

  @override
  State<inputStokDanButtonAjukan> createState() => _inputStokDanButtonAjukanState();
}

class _inputStokDanButtonAjukanState extends State<inputStokDanButtonAjukan> {

  int jumlah = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
    
        InputQty(
          decoration: QtyDecorationProps(
            plusBtn: Icon(
              Icons.add,
              color: AppColors.green1,
            ),
            btnColor: AppColors.error,
          ),
          initVal: 1,
          steps: 1,
          minVal: 1,
          maxVal: widget.widget.stok,
          onQtyChanged: (valueStok) {
            setState(() {
              jumlah = valueStok;
            });
          },
        ),
    
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black1.withOpacity(0.20),
                offset: Offset(0, 4),
                blurRadius: 10
              )
            ]
          ),
          child: ElevatedButton(
            onPressed: widget.isAgree && !isLoading ? () async {
              setState(() => isLoading = true);

              try {
                final response = await PeminjamanService.ajukanPeminjaman(
                  idAlat: widget.id_alat,
                  jumlah: jumlah,
                );

                final data = response.data;

                if (response.statusCode == 201) {
                  Get.snackbar(
                    "Berhasil", 
                    data['message'],
                    backgroundColor: AppColors.green1.withOpacity(0.1),
                    colorText: AppColors.green1,
                    margin: EdgeInsets.all(15)
                  );
                  Navigator.pop(context);
                } else {
                  Get.snackbar(
                    "Gagal", 
                    data['message'] ?? "Terjadi kesalahan, harap coba lagi nanti",
                    backgroundColor: AppColors.error.withOpacity(0.1),
                    colorText: AppColors.error,
                    margin: EdgeInsets.all(15)
                  );
                  Navigator.pop(context);
                }

              } finally {
                setState(() => isLoading = false);
              }

            } : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(160, 60),
              backgroundColor: widget.isAgree
                  ? AppColors.green1
                  : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "Ajukan Peminjaman",
              style: TextStyle(
                color: AppColors.bgWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}