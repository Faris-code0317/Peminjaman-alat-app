import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';

import 'package:peminjaman_alat_app/features/home/page/home_page.dart';
import 'package:peminjaman_alat_app/features/status/page/status_page.dart';
import 'package:peminjaman_alat_app/features/home/carousel.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';
import 'package:peminjaman_alat_app/core/services/auth_services.dart';

import 'package:peminjaman_alat_app/routes/app_routes.dart';

// import 'package:get/get.dart';
// import 'package:peminjaman_alat_app/core/services/auth_services.dart';
// import '../../../routes/app_routes.dart';
// import 'logo_list.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Frosted bottom bar',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Frosted bottom bar'),
//     );
//   }
// }

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;

  final List<Color> colors = [
    AppColors.green1,
    AppColors.green1,
    // AppColors.green1,
    AppColors.green1,
    // AppColors.green1,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 3, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ClipRect(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppColors.bgPage
            )
          ),
          child: FrostedBottomBar(
            opacity: 0.6,
            sigmaX: 5,
            sigmaY: 5,
            child: TabBar(
              indicatorPadding: const EdgeInsets.all(6),
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                color: Colors.white,
              ),
              // indicator: const UnderlineTabIndicator(
              //   borderSide: BorderSide(color: Colors.blue, width: 4),
              //   insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
              // ),
              tabs: [
                TabsIcon(
                    icons: Icons.home,
                    color: currentPage == 0 ? colors[0] : Colors.white),
                // TabsIcon(
                //     icons: Icons.search,
                //     color: currentPage == 1 ? colors[1] : Colors.white),
                // TabsIcon(
                //     icons: Icons.queue_play_next,
                //     color: currentPage == 2 ? colors[2] : Colors.white),
                // TabsIcon(
                //     icons: Icons.file_download,
                //     color: currentPage == 3 ? colors[3] : Colors.white),
                TabsIcon(
                    icons: Icons.content_paste_search_sharp,
                    color: currentPage == 1 ? colors[1] : Colors.white),
                TabsIcon(
                    icons: Icons.person_3,
                    color: currentPage == 2 ? colors[2] : Colors.white),
              ],
            ),
            borderRadius: BorderRadius.circular(500),
            duration: const Duration(milliseconds: 800),
            hideOnScroll: true,
            body: (context, controller) => TabBarView(
              controller: tabController,
              dragStartBehavior: DragStartBehavior.down,
              physics: const BouncingScrollPhysics(),
              children: [
                HomePage(scrollController: controller,),
                StatusPage(),
                // CarouselDemo(),
                MyHomePage(title: "Hello",),
                // Center(
                //   child:ListView.builder(
                //     controller: controller,
                //     itemBuilder: (context, index) {
                //       return const Card(child: FittedBox(child: FlutterLogo()));
                //     },
                //   ),
                // ),
              ],
              // children: colors
              //     .map(
              //       (e) => ListView.builder(
              //         controller: controller,
              //         itemBuilder: (context, index) {
              //           return const Card(child: FittedBox(child: FlutterLogo()));
              //         },
              //       ),
              //     )
              //     .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icons,
          color: color,
        ),
      ),
    );
  }
}