import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';
import 'package:peminjaman_alat_app/features/status/widget/statusTab_widget.dart';
import 'package:peminjaman_alat_app/features/status/widget/statusList_widget.dart';

class StatusPage extends StatefulWidget {
  StatusPage({
    super.key, 
    // required this.scrollController
  });
    
  // final ScrollController scrollController;

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage>
    with AutomaticKeepAliveClientMixin {

  final StatusController controller = Get.find();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("STATUS CONTROLLER HASH: ${controller.hashCode}");
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: Column(
        children: [

          const SizedBox(height: 15),

          /// TAB
          StatusTabWidget(),

          const SizedBox(height: 10),

          Expanded(
            child: Obx(() {

              if (controller.isFirstLoad.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.statusList.isEmpty) {
                return const _EmptyWidget();
              }

              return StatusListWidget();

            }),
          )
        ],
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Image(
          image: AppAssets.notFoundIcon,
          width: 260,
        ),

        const SizedBox(height: 10),

        const Text(
          "⛔ Data tidak ditemukan",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "Belum ada peminjaman pada status ini",
          style: TextStyle(
            color: AppColors.grey1,
            fontSize: 13,
          ),
        ),

      ],
    );
  }
}