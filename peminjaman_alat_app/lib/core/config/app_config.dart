import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {

  static String get baseUrl {

    if (kIsWeb) {
      return dotenv.env['LOCAL_API']!;
    }

    // if (Platform.isAndroid) {
    //   return dotenv.env['EMULATOR_API']!;
    // }

    return dotenv.env['DEVICE_API']!;
  }

}