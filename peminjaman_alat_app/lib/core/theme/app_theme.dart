import 'package:flutter/material.dart';

class AppColors {

  static const Color bgWhite = Color(0xFFFFFFFF);
  static const Color bgLight1 = Color(0xFFF2F3F7);
  static const Color bgLight2 = Color(0xFFEDEFF5);

  static const Color primaryRegister = Color(0xFFA7C1E7);
  static const Color primaryLogin = Color(0xFFB7A7E7);

  static const Color error = Color(0xFFA13842);
  static const Color success = Color(0xFF41C74E);

  static const Color link = Colors.blue;

}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    fontFamily: 'Roboto',

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryRegister,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgWhite,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.primaryRegister,
          width: 2,
        ),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.bgWhite,
      ),
    ),
  );
}

class AppAssets {
  static const ImageProvider loginIcon = AssetImage("assets/icons/1.png");
  static const ImageProvider regisIcon = AssetImage("assets/icons/2.png");
}