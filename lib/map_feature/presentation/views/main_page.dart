import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_websocket_map/core/endpoint_address.dart';
import 'package:flutter_websocket_map/core/text_constants.dart';
import 'package:flutter_websocket_map/map_feature/domain/entities/location.dart';
import 'package:flutter_websocket_map/map_feature/presentation/blocs/map_bloc.dart';
import 'package:flutter_websocket_map/map_feature/presentation/blocs/map_state.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late WebSocketBloc _webSocketBloc;
  final List<Marker> _markers = [];

  @override
  void initState() {
    super.initState();

    _webSocketBloc = Get.find<WebSocketBloc>();
  }

  @override
  void dispose() {
    _webSocketBloc.closeWebSocket();
    _webSocketBloc.close();
    super.dispose();
  }

  void _addMarker(Location location) {
    final marker = Marker(
      point: LatLng(location.latitude, location.longitude),
      builder: (context) => const Icon(Icons.pin_drop_rounded),
    );

    _markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WebSocketBloc, WebSocketState>(
      bloc: _webSocketBloc,
      builder: (context, state) {
        if (state is WebSocketLocationReceived) {
          _addMarker(state.location);
          return _buildMap();
        } else if (state is WebSocketConnected) {
          return _buildMap();
        } else if (state is WebSocketError) {
          return Center(
            child: Text('Error: ${state.errorMessage}'),
          );
        } else if (state is WebSocketClosed) {
          return const GetSnackBar(message: APPTextConstants.closedSocket);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      options: MapOptions(
        center: const LatLng(35.761648, 51.399856),
        zoom: 10.0,
      ),
      children: [
        TileLayer(
          urlTemplate: EndPointAddress.mapAddress,
          userAgentPackageName: 'com.example.flutter_websocket_map',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: _markers,
        ),
      ],
    );
  }
}
