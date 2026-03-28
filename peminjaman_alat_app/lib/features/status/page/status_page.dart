import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/widgets/empty_widget.dart';

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
                  child: CircularProgressIndicator(color: AppColors.green1,),
                );
              }

              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.green1,),
                );
              }

              // if (controller.statusList.isEmpty) {
              //   return EmptyWidget(
              //     title: controller.emptyTitle,
              //     description: controller.emptyDescription,
              //   );
              // }

              return RefreshIndicator(
                backgroundColor: AppColors.bgWhite,
                color: AppColors.green1,
                onRefresh: () async {
                  await controller.fetchStatus(
                    controller.statusTab[controller.selectedStatusIndex.value],
                  );
                },
                child: controller.statusList.isEmpty
                    ? ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 100),
                          EmptyWidget(
                            title: controller.emptyTitle,
                            description: controller.emptyDescription,
                          ),
                        ],
                      )
                    : StatusListWidget(),
              );
            }),
          )
        ],
      ),
    );
  }
}