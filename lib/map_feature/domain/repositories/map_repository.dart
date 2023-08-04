import 'package:flutter_websocket_map/map_feature/domain/entities/location.dart';

abstract class MapRepository {
  Future<void> openWebSocket(Function(Location location) onLocationReceived);
  void closeWebSocket();
}
