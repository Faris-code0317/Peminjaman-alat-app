import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'package:peminjaman_alat_app/features/profile/controller/profile_controller.dart';
import 'package:peminjaman_alat_app/features/auth/controller/auth_controller.dart';
import 'package:peminjaman_alat_app/features/home/controller/home_controller.dart';
import 'package:peminjaman_alat_app/features/status/controller/status_controller.dart';


import 'package:peminjaman_alat_app/routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> 
  with AutomaticKeepAliveClientMixin {

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
    return Scaffold(
      // appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'INPUT QUANTITY',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  'by: pmatatias.dev',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
              Center(
                child: 
                IconButton(
                 onPressed: () async {
                    final auth = context.read<AuthController>();
        
                    await auth.logout();
        
                    await Future.delayed(const Duration(milliseconds: 100));
        
                    Get.delete<HomeController>();
                    Get.delete<StatusController>();
                    Get.delete<ProfileController>();
        
                    Get.offAllNamed(AppRoutes.LOGIN);
        
                  },
                  icon: const Icon(Icons.logout),
                ),
              )
              // IconButton(
              //     onPressed: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const Example1(),
              //         )),
              //     icon: const Icon(Icons.exit_to_app))
            ],
          ),
        ),
      ),
    );
  }
}