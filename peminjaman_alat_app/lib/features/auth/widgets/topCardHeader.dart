import 'package:flutter/material.dart';

class topCardImage extends StatelessWidget {
  final ImageProvider imageAsset;
  final Color color;
  const topCardImage({
    required this.imageAsset,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(5),
      height: 470,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
         gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ 
            color,
            Color(0xFFEDEFF5), 
          ],
        ),
        image: DecorationImage(
          image: imageAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}