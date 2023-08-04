import 'dart:async';

import 'package:flutter_websocket_map/map_feature/data/data_sources/websocket_data_source.dart';
import 'package:flutter_websocket_map/map_feature/domain/entities/location.dart';
import 'package:flutter_websocket_map/map_feature/domain/repositories/map_repository.dart';

class MapRepositoryImpl implements MapRepository {
  final WebSocketDataSource webSocketDataSource;

  MapRepositoryImpl({required this.webSocketDataSource});

  @override
  void closeWebSocket() {
    webSocketDataSource.closeWebSocket();
  }

  @override
  Future<void> openWebSocket(
      Function(Location location) onLocationReceived) async {
    await webSocketDataSource.connectWebSocket(onLocationReceived);
  }
}
