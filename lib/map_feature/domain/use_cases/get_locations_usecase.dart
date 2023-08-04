import 'dart:async';

import 'package:flutter_websocket_map/map_feature/domain/entities/location.dart';
import 'package:flutter_websocket_map/map_feature/domain/repositories/map_repository.dart';

class WebSocketUseCase {
  final MapRepository repository;

  final StreamController<Location> _locationController =
      StreamController<Location>();
  Stream<Location> get locationStream => _locationController.stream;

  WebSocketUseCase({required this.repository});

  Future<void> openWebSocket(
      Function(Location location) onLocationReceived) async {
    await repository.openWebSocket(onLocationReceived);
  }

  void closeWebSocket() {
    repository.closeWebSocket();
  }

  void dispose() {
    _locationController.close();
  }
}
