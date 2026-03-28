import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:peminjaman_alat_app/core/widgets/search_widget.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/alatList_widget.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/backButton.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/dropdownFilterButton_widget.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/alat/controller/alat_controller.dart';


class AlatList extends StatefulWidget {
  const AlatList({
    super.key,
    required this.alatController,
  });

  final AlatController alatController;

  @override
  State<AlatList> createState() => _AlatListState();
}

class _AlatListState extends State<AlatList> {
  final searchController = TextEditingController();
  final multiValueListenable = ValueNotifier<List<String>>([]);

  final AlatController Alatcontroller = Get.find();

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return RefreshIndicator(
      backgroundColor: AppColors.bgWhite,
      color: AppColors.green1,
      onRefresh: () async {
        await Alatcontroller.fetchAlat();
      },
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: ClipRect(
          child: Container(
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: AppColors.bgPage
            //   )
            // ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
      
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.bgWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black1.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        ),
                        child: Align(
                        alignment: Alignment.topLeft,
                        child: backButton_widget()
                      ),
                    ),
      
                   Padding(
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom:  20
                      ),
                      child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.10),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: SearchField(
                                  controller: searchController,
                                  onChanged: (value) {
                                  print("Search: $value");
                              },
                            ), 
                          ),
                        ),
                        
                        filterAlatByKategori_widget(multiValueListenable: multiValueListenable)
                        
                        ],
                      ),
                    ),
                    
                    AlatListWidget(alatController: Get.find<AlatController>(),),
                  ],
                ),
              ),
            )
            )
          )
        ),
    );
    }
  }


