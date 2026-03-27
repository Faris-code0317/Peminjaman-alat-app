import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/features/alat/widgets/inputStokAjukan_button.dart';
import 'package:peminjaman_alat_app/features/syaratKetentuan/widget/syarat_ketentuan_widget.dart';

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

              const SyaratKetentuanWidget(),

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
