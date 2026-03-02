import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/widgets/search_widget.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class search_home extends StatelessWidget {
  const search_home({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
       children: [
         Expanded(
           child: Container(
            width: double.infinity,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(15),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black.withOpacity(0.05),
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
          ElevatedButton(
            onPressed: (){}, 
            style: ElevatedButton.styleFrom(
              minimumSize: Size(45, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              backgroundColor: AppColors.green1,
            ),
            child: Icon(
              Icons.filter_alt,
              color: AppColors.bgWhite,
            ) 
          )
         ],
       ),
    );
  }
}