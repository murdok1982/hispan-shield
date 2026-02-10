import 'package:flutter/services.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class SmsMonitorService {
  static const platform = MethodChannel('com.mtd/sms');
  final Function(Map<String, dynamic>) onSmsReceived;
  
  SmsMonitorService({required this.onSmsReceived}) {
    platform.setMethodCallHandler(_handleMethod);
  }
  
  Future<dynamic> _handleMethod(MethodCall call) async {
    if (call.method == 'onSmsReceived') {
      final Map<dynamic, dynamic> data = call.arguments;
      final smsEvent = _processSmsEvent(data);
      onSmsReceived(smsEvent);
    }
  }
  
  Map<String, dynamic> _processSmsEvent(Map<dynamic, dynamic> rawData) {
    final sender = rawData['sender'] as String;
    final message = rawData['message'] as String;
    final timestamp = rawData['timestamp'] as int;
    
    return {
      "sender_hash": _hashPhone(sender),
      "extracted_urls": _extractUrls(message),
      "timestamp": DateTime.fromMillisecondsSinceEpoch(timestamp).toIso8601String(),
      "is_suspicious_local_score": _calculateLocalScore(message),
      "message_length": message.length
    };
  }
  
  String _hashPhone(String phone) {
    var bytes = utf8.encode(phone);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  List<String> _extractUrls(String text) {
    final urlPattern = RegExp(r'https?://[^\s]+');
    return urlPattern.allMatches(text).map((m) => m.group(0)!).toList();
  }
  
  double _calculateLocalScore(String message) {
    // Simple local heuristic
    final suspiciousKeywords = ['premio', 'urgente', 'verificar', 'haz clic'];
    int count = 0;
    for (var keyword in suspiciousKeywords) {
      if (message.toLowerCase().contains(keyword)) count++;
    }
    return (count / suspiciousKeywords.length).clamp(0.0, 1.0);
  }
}
