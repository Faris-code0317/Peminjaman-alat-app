import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/features/alat/widgets/alatList_widget.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/backButton.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/peminjamanBottomSheet_widget.dart';

import 'package:peminjaman_alat_app/features/alat/controller/alat_controller.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/utils/helpers.dart';

class alatDetail_page extends StatefulWidget {
  alatDetail_page({
    super.key, 
    required this.gambar,
    required this.stok,
    required this.kategori,
    required this.namaAlat,
    // required this.alatController,
  });

  final String gambar;
  final int stok;
  final String kategori;
  final String namaAlat;
  // final AlatController alatController;

  @override
  State<alatDetail_page> createState() => _alatDetail_pageState();
}

class _alatDetail_pageState extends State<alatDetail_page> {

  final AlatController alatController = Get.put(AlatController());

  Color getStokColor(int stok) {
    if (stok >= 11) {
      return AppColors.success;
    } else if (stok <= 5) {
      return AppColors.error;
    } else {
      return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {

  // final alatList = widget.alatController.filteredAlatList;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.bgPage
        )
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                        color: AppColors.bgWhite,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.black1.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                          ),
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            getImageUrl(widget.gambar)
                          )
                        )
                      ),
                    ),
                  
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black1.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: backButton_widget()
                        )
                      ),
                    )
                  ],
                ),
                    
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black1.withOpacity(0.15),
                        offset: Offset(0, 4),
                        blurRadius: 10
                      ),
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 8),
                        child: Text(
                          widget.namaAlat,
                          style: TextStyle(
                            color: AppColors.black1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
                      ),
                    
                      Text.rich(
                        TextSpan(
                          text: "Jenis / kategori Alat: ",
                          style: TextStyle(
                            color: Colors.grey[400]
                          ),
                          children: [
                            TextSpan(
                              text: widget.kategori,
                              style: TextStyle(
                                color: AppColors.green1,
                                fontSize: 14
                              ),
                            )
                          ]
                        )
                      ),
                    
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text.rich(
                          TextSpan(
                            text: widget.stok.toString(),
                            style: TextStyle(
                              color: getStokColor(widget.stok)
                            ),
                            children: [
                              TextSpan(
                                text: " Stok tersedia",
                                style: TextStyle(
                                  color: getStokColor(widget.stok),
                                  fontSize: 14
                                ),
                              )
                            ]
                          )
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black1.withOpacity(0.15),
                        offset: Offset(0, 4),
                        blurRadius: 10
                      )
                    ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Rekomendasi alat yang tersedia",
                        style: TextStyle(
                          color: AppColors.green1,
                          fontSize: 18
                        ),
                      )
                    ],
                  ),
                ),
                    
                AlatListWidget(alatController: alatController),
                    
              ],
            ),
          ),
        ),


        bottomNavigationBar: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.bgWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25)
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.black1.withOpacity(0.30),
                offset: Offset(0, 4),
                blurRadius: 15
              )
            ]
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Text(
              //   "Minimal jumlah peminjaman 1",
              //   style: TextStyle(
              //     color: AppColors.warning
              //   ),
              // ),

              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black1.withOpacity(0.10),
                      blurRadius: 10,
                      offset: Offset(0, 4)
                    )
                  ]
                ),
                child: ElevatedButton(
                  onPressed: (){
                    showModalBottomSheet(
                      context: context, 
                      isScrollControlled: false,
                      builder: (context) => peminjamanBottomSheet_widget(stok: widget.stok),
                    );
                  }, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.green1,
                    minimumSize: Size(180, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(25)
                    )
                  ),
                  child: Text(
                    "Pinjam alat",
                    style: TextStyle(
                      color: AppColors.bgWhite
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}