import 'package:equatable/equatable.dart';
import 'package:flutter_websocket_map/map_feature/domain/entities/location.dart';

abstract class WebSocketState {}

class WebSocketInitial extends WebSocketState {}

class WebSocketConnected extends WebSocketState {
  final String message;

  WebSocketConnected(this.message);
}

class WebSocketClosed extends WebSocketState {}

class WebSocketError extends WebSocketState {
  final String errorMessage;

  WebSocketError(this.errorMessage);
}

class WebSocketLocationReceived extends WebSocketState {
  final Location location;

  WebSocketLocationReceived(this.location);
}
