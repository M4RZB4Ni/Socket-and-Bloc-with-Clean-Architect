import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_websocket_map/core/text_constants.dart';
import 'package:flutter_websocket_map/map_feature/domain/use_cases/get_locations_usecase.dart';
import 'package:flutter_websocket_map/map_feature/presentation/blocs/map_state.dart';

class WebSocketBloc extends Cubit<WebSocketState> {
  final WebSocketUseCase useCase;

  WebSocketBloc({required this.useCase}) : super(WebSocketInitial()) {
    setupWebSocketListener();
  }

  Future<void> setupWebSocketListener() async {
    try {
      await useCase.openWebSocket((location) {
        emit(WebSocketLocationReceived(location));
      });
      emit(WebSocketConnected(APPTextConstants.connected));
    } catch (e) {
      emit(WebSocketError(APPTextConstants.failed));
    }
  }

  void closeWebSocket() {
    useCase.closeWebSocket();
    emit(WebSocketClosed());
  }
}
