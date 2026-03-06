import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/widgets/search_widget.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/alatList_widget.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/backButton.dart';
import 'package:peminjaman_alat_app/features/alat/widgets/dropdownFilterButton_widget.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/controller/alat_controller.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [

                 backButton_widget(),

                 Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom:  35
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
                      const SizedBox(width: 10),
                      
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
      );
    }
  }


