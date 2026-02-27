// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

// class StorageService {
//   static const _storage = FlutterSecureStorage();

//   static const _tokenKey = "auth_token";

//   static Future<void> saveToken(String token) async {
//     await _storage.write(key: _tokenKey, value: token);
    
//     final savedToken = await StorageService.getToken();
//     print("TOKEN TERSIMPAN: $savedToken");  
//   }

//   static Future<String?> getToken() async {
//     return await _storage.read(key: _tokenKey);
//   }

//   static Future<void> deleteToken() async {
//     await _storage.delete(key: _tokenKey);

//     final token = await StorageService.getToken();
// print("TOKEN SETELAH LOGOUT: $token");

//   }
// }

class StorageService {
  static final _box = GetStorage();
  static const _tokenKey = "auth_token";

  static Future<void> saveToken(String token) async {
    await _box.write(_tokenKey, token);
    print("TOKEN TERSIMPAN: ${_box.read(_tokenKey)}");
  }

  static Future<String?> getToken() async {
    return _box.read(_tokenKey);
  }

  static Future<void> deleteToken() async {
    await _box.remove(_tokenKey);
    print("TOKEN SETELAH LOGOUT: ${_box.read(_tokenKey)}");
  }
}
