import 'package:flutter/material.dart';
import 'auth_service.dart';

class DeviceRegistrationScreen extends StatefulWidget {
  const DeviceRegistrationScreen({super.key});

  @override
  State<DeviceRegistrationScreen> createState() => _DeviceRegistrationScreenState();
}

class _DeviceRegistrationScreenState extends State<DeviceRegistrationScreen> {
  final AuthService _authService = AuthService();
  String _status = "Device not registered";
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
      _status = "Registering...";
    });

    try {
      final result = await _authService.registerDevice();
      setState(() {
        _status = "Registered! ID: ${result['id']}";
      });
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mobile Threat Defense")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.security, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              Text(_status, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _register,
                  child: const Text("Register Device"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
