import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/features/alat/services/peminjaman_services.dart';

import 'package:peminjaman_alat_app/features/alat/widgets/peminjamanBottomSheet_widget.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';


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
              jumlah = valueStok.toInt();
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
                    "✅ Berhasil", 
                    data['message'],
                    backgroundColor: AppColors.green1.withOpacity(0.5),
                    colorText: AppColors.bgWhite,
                    margin: EdgeInsets.all(15)
                  );
                  Navigator.pop(context);
                } else {
                  Get.snackbar(
                    "🚫 Gagal", 
                    data['message'] ?? "Terjadi kesalahan, harap coba lagi nanti",
                    backgroundColor: AppColors.error.withOpacity(0.5),
                    colorText: AppColors.bgWhite,
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