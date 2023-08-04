import 'package:flutter_websocket_map/map_feature/data/data_sources/websocket_data_source.dart';
import 'package:flutter_websocket_map/map_feature/data/repositories/map_repository_impl.dart';
import 'package:flutter_websocket_map/map_feature/domain/repositories/map_repository.dart';
import 'package:flutter_websocket_map/map_feature/domain/use_cases/get_locations_usecase.dart';
import 'package:flutter_websocket_map/map_feature/presentation/blocs/map_bloc.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebSocketDataSource>(
      () => WebSocketDataSourceImpl(),
      fenix: true,
    );

    Get.lazyPut<MapRepository>(
      () => MapRepositoryImpl(
        webSocketDataSource: Get.find<WebSocketDataSource>(),
      ),
      fenix: true,
    );

    Get.lazyPut<WebSocketUseCase>(
      () => WebSocketUseCase(
        repository: Get.find<MapRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<WebSocketBloc>(
      () => WebSocketBloc(
        useCase: Get.find<WebSocketUseCase>(),
      ),
      fenix: true,
    );
  }
}
