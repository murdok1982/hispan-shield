import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/api_config.dart';

class EventReportingService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));
  
  Future<String?> _getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('device_id');
  }
  
  Future<bool> reportSmsEvent(Map<String, dynamic> smsEvent) async {
    try {
      final deviceId = await _getDeviceId();
      if (deviceId == null) return false;
      
      final response = await _dio.post(
        '/events/sms',
        data: smsEvent,
        options: Options(headers: {'X-Device-ID': deviceId})
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print("Error reporting SMS event: $e");
      return false;
    }
  }
  
  Future<bool> reportCallEvent(Map<String, dynamic> callEvent) async {
    try {
      final deviceId = await _getDeviceId();
      if (deviceId == null) return false;
      
      final response = await _dio.post(
        '/events/call',
        data: callEvent,
        options: Options(headers: {'X-Device-ID': deviceId})
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print("Error reporting call event: $e");
      return false;
    }
  }
  
  Future<bool> reportApps(List<Map<String, dynamic>> apps) async {
    try {
      final deviceId = await _getDeviceId();
      if (deviceId == null) return false;
      
      final response = await _dio.post(
        '/events/apps',
        data: apps,
        options: Options(headers: {'X-Device-ID': deviceId})
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print("Error reporting apps: $e");
      return false;
    }
  }
}
