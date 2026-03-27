import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:peminjaman_alat_app/features/home/controller/home_controller.dart';

import 'package:peminjaman_alat_app/features/home/widgets/appBar_home.dart';
import 'package:peminjaman_alat_app/features/home/widgets/searchBar_home.dart';
import 'package:peminjaman_alat_app/features/home/widgets/imageCarousel_home.dart';
import 'package:peminjaman_alat_app/features/home/widgets/kategoriTab_home.dart';
import 'package:peminjaman_alat_app/features/home/widgets/alayByKategoriList_home.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
// import 'package:peminjaman_alat_app/core/services/auth_services.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.scrollController});
    
  final ScrollController scrollController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
    final HomeController Homecontroller = Get.find();

    final searchController = TextEditingController();

  // final AlatController alatController = Get.find();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, 
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Obx(() {
          final user = Homecontroller.userInfo.value;
          if (Homecontroller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.green1,));
          }
      
          if (Homecontroller.errorMessage.isNotEmpty) {
            return Center(
              child: Text(Homecontroller.errorMessage.value),
            );
          }
          return SingleChildScrollView(
            controller: widget.scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  appBar_widget(user: user),
              
                  search_home(searchController: searchController),
              
                  HomeCarousel(),
              
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Kategori",
                          style: TextStyle(
                            color: AppColors.green1,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),
                        ),
              
                        ElevatedButton(
                          onPressed: (){
                             Get.offAllNamed(AppRoutes.ALATLIST);
                            // Navigator.push(
                            //   context, 
                            //   MaterialPageRoute(
                            //     builder: (context) => AlatList(alatController: alatController),
                            //   )
                            // );
                          }, 
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.bgLight1,
                            padding: EdgeInsets.all(2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(5)
                            ),
                            side: BorderSide(
                              color: AppColors.green1
                            )
                          ),
                          child: Text(
                            "lihat semua",
                            style: TextStyle(
                              color: AppColors.green1,
                              fontSize: 10
                            ),
                          )
                        ),
                    
                      ],
                    ), 
                  ),
              
                  KategoriTab(),
              
                  KategoriList(homeController: Homecontroller),
                ],
              ),
            ),
          );
        }
      );
  }
}


