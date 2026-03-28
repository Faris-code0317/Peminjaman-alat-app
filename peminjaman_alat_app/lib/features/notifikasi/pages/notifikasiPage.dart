import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/widgets/empty_widget.dart';

import 'package:peminjaman_alat_app/features/notifikasi/controller/notifikasi_controller.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> 
  with AutomaticKeepAliveClientMixin{

  final NotifikasiController controller = Get.find();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.bgPage
          )
        ),
      child: Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.bgWhite,
        leading: InkWell(
            onTap: () {
              Get.offAllNamed(AppRoutes.HOME);
            },
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.fromLTRB(15, 7, 0, 7),
              decoration: BoxDecoration(
                color: AppColors.bgWhite,
                borderRadius: BorderRadius.circular(40/2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black1.withOpacity(0.15),
                    blurRadius: 10,
                    offset: Offset(0, 4)
                  )
                ]
              ),

              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.green1,
                ),
              ),
            ),
          ),

        centerTitle: false,
        title: Text(
          "Notifikasi",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.green1
          ),
        ),
      ),

      body: Obx(() {
        
            if (controller.isLoading.value) {
             return const Center(
              child: CircularProgressIndicator(color: AppColors.green1),
             );
            }
        
            // if (controller.isEmpty) {
            //  return const _EmptyWidget();
            // }
        
            return EmptyWidget(
              title: controller.emptyTitle,
              description: controller.emptyDescription,
            );
        
        }),
      ),
    );
  }
}

