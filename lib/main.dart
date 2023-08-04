import 'package:flutter/material.dart';
import 'package:flutter_websocket_map/core/dependency_injection.dart';
import 'package:flutter_websocket_map/map_feature/presentation/views/main_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MainBinding(),
      title: 'WWebSocket Map Demo By Hamidreza',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WebSocket Map Demo By Hamidreza'),
        ),
        body:  MapPage(),
      ),
    );
  }
}
