import 'package:flutter/cupertino.dart';
import 'package:flutter_websocket_map/core/endpoint_address.dart';
import 'package:flutter_websocket_map/map_feature/domain/entities/location.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class WebSocketDataSource {
  Future<void> connectWebSocket(Function(Location location) onLocationReceived);
  Future<void> closeWebSocket();
}

class WebSocketDataSourceImpl implements WebSocketDataSource {
  WebSocketChannel? _channel;

  @override
  Future<void> closeWebSocket() async {
    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
    }
  }

  @override
  Future<void> connectWebSocket(
      Function(Location location) onLocationReceived) async {

    _channel =
        WebSocketChannel.connect(Uri.parse(EndPointAddress.socketAddress));
    _channel!.stream.listen((message) {
      final List<String> splited = message.toString().split(',');
      var loc = Location(
          double.tryParse(splited[0]) ?? 0, double.tryParse(splited[1]) ?? 0);
      onLocationReceived(loc);
    });
  }

  Location processMessage(String message) {
    late double latitude;
    late double longitude;
    final List<String> locationParts = message.split(',');
    if (locationParts.length == 2) {
      latitude = double.tryParse(locationParts[0]) ?? 0;
      longitude = double.tryParse(locationParts[1]) ?? 0;
    }
    return Location(latitude, longitude);
  }
}
