import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/profile/controller/profile_controller.dart';

import 'package:peminjaman_alat_app/features/profile/widgets/logoutButton_widget.dart';
import 'package:peminjaman_alat_app/features/profile/widgets/userInfo_widget.dart';
import 'package:peminjaman_alat_app/features/profile/widgets/syaratKetentuanButton_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> 
  with AutomaticKeepAliveClientMixin {

  final ProfileController Profilecontroller = Get.find();

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
      final user = Profilecontroller.userInfo.value;
      
      if (Profilecontroller.isLoading.value) {
        return const Center(child: CircularProgressIndicator(color: AppColors.green1,));
       }
      
       if (Profilecontroller.errorMessage.isNotEmpty) {
        return Center(
         child: Text(Profilecontroller.errorMessage.value),
        );
       }

      return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                userInfo_widget(user: user,),

                SizedBox(height: 20),

                syaratKetentuanButton_widget(),

                SizedBox(height: 5),

                logoutButton_widget()

              ],
            ),
          ),
        );
    });
  }
}