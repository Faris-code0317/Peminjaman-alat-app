import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:peminjaman_alat_app/core/theme/app_theme.dart';

class loginButtonOption extends StatefulWidget {
  const loginButtonOption({
    super.key,
  });

  @override
  State<loginButtonOption> createState() => _loginButtonOptionState();
}

class _loginButtonOptionState extends State<loginButtonOption> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _isVisible = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _isVisible ? Offset.zero : Offset(0, 0.5),
      duration: Duration(milliseconds: 2000),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: Duration(milliseconds: 2000),
        child: Container(
          width: double.infinity,
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey.shade200
                    ),
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.google,
                    color: AppColors.error,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey.shade200
                    ),
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.twitter,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: Colors.grey.shade200
                    ),
                    color: AppColors.bgWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.facebook,
                    color: AppColors.link,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
