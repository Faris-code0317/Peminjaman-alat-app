import 'package:flutter/material.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class topCardImage extends StatefulWidget {
  final ImageProvider imageAsset;
  final Color color;
  const topCardImage({
    required this.imageAsset,
    required this.color,
    super.key,
  });

  @override
  State<topCardImage> createState() => _topCardImageState();
}

class _topCardImageState extends State<topCardImage> {
  bool _isVisible = false;

  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(Duration(milliseconds: 100), () {
  //     setState(() {
  //       _isVisible = true;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return
     AnimatedSlide(
      offset: _isVisible ? Offset.zero : Offset(0, -0.5),
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: Duration(milliseconds: 1000),
        child: 
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            bottom: 8,
          ),
          padding: const EdgeInsets.all(5),
          height: 470,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ 
                widget.color,
                AppColors.bgLight2, 
              ],
            ),
            image: DecorationImage(
              image: widget.imageAsset,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}