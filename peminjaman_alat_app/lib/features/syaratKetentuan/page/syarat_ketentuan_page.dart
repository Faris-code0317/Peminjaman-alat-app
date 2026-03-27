import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

import 'package:peminjaman_alat_app/features/syaratKetentuan/widget/syarat_ketentuan_widget.dart';

class SyaratKetentuanPage extends StatefulWidget{
  const SyaratKetentuanPage({super.key});

  @override
  State<SyaratKetentuanPage> createState() => _SyaratKetentuanPageState();
}

class _SyaratKetentuanPageState extends State<SyaratKetentuanPage> 
  with AutomaticKeepAliveClientMixin{

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
          title: const Text("Syarat & Ketentuan"),
          centerTitle: false,
          backgroundColor: AppColors.bgWhite,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
              
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.green1,
              ),
            ),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: SyaratKetentuanWidget(),
        ),
      ),
    );
  }
}