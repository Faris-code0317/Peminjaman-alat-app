import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  final List<String> imgList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
  ];

  final List<String> textList = [
    "Laptop",
    "Proyektor",
    "Hardware"
  ];

  final List<String> descList = [
    "Kamu bisa meminjam laptop milik sekolah untuk digunakan belajar",
    "Kamu bisa meminjam proyektor untuk digunakan presentasi dalam belajar",
    "Kamu bisa meminjam Hardware atau perangkat keras untuk kebutuhan belajar"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        CarouselSlider(
          items: imgList.asMap().entries.map((entry) {
            return Stack(
              children: [

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      entry.value,
                      fit: BoxFit.fitWidth,
                      width: double.infinity,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textList[entry.key],
                        style: TextStyle(
                          color: AppColors.green1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        descList[entry.key],
                        style: TextStyle(
                          color: AppColors.grey1,
                          fontSize: 11,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }).toList(),

          carouselController: _controller,

          options: CarouselOptions(
            height: 150,
            autoPlay: true,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == entry.key
                      ? AppColors.green1
                      : AppColors.grey1,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}