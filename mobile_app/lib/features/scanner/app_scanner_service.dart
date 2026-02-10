import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class AppScannerService {
  static const platform = MethodChannel('com.mtd/scanner');
  
  Future<List<Map<String, dynamic>>> scanInstalledApps() async {
    try {
      final List<dynamic> apps = await platform.invokeMethod('scanInstalledApps');
      return apps.cast<Map<String, dynamic>>();
    } catch (e) {
      print("Error scanning apps: $e");
      return [];
    }
  }
  
  Map<String, dynamic> prepareAppEventForBackend(Map<String, dynamic> app) {
    return {
      "package_name": app['packageName'],
      "version_code": app['versionCode'],
      "signature_digest": _generateHash(app['packageName']),  // Placeholder
      "installer_source": app['installerPackage'],
      "permissions": app['permissions'] ?? [],
      "install_time": DateTime.fromMillisecondsSinceEpoch(app['firstInstallTime']).toIso8601String()
    };
  }
  
  String _generateHash(String input) {
    var bytes = utf8.encode(input);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
}
