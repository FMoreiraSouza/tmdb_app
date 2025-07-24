import 'package:get_it/get_it.dart';
import 'package:tmdb_app/core/network/dio_client.dart';

class DioDIManager {
  static final GetIt _getIt = GetIt.instance;

  static void registerApi() {
    if (!_getIt.isRegistered<DioClient>()) {
      _getIt.registerSingleton<DioClient>(DioClient());
    }
  }

  static DioClient getDio() {
    return _getIt.get<DioClient>();
  }
}
