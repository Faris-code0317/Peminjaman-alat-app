import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      
          Image(
            image: AppAssets.notFoundIcon,
            width: 260,
          ),
      
          const SizedBox(height: 10),
      
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
      
          const SizedBox(height: 4),
      
          Text(
            description,
            style: TextStyle(
              color: AppColors.grey1,
              fontSize: 13,
            ),
          ),
      
        ],
      ),
    );
  }
}