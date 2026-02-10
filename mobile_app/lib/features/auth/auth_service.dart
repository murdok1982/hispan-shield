import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api_config.dart';
import 'dart:io';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  Future<Map<String, dynamic>> registerDevice() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      String model = "Unknown";
      String manufacturer = "Unknown";
      String osVersion = "Unknown";
      String androidId = "Unknown";

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        model = androidInfo.model;
        manufacturer = androidInfo.manufacturer;
        osVersion = androidInfo.version.release;
        androidId = androidInfo.id;
      }

      final response = await _dio.post('/auth/device/register', data: {
        "manufacturer": manufacturer,
        "model": model,
        "os_version": osVersion,
        "android_id": androidId
      });

      if (response.statusCode == 200) {
        // Save device ID
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('device_id', response.data['id']);
        return response.data;
      } else {
        throw Exception("Registration failed: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error registering device: $e");
    }
  }
}
