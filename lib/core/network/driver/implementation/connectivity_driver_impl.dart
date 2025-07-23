import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:tmdb_app/core/network/driver/connectivity_driver.dart';

class ConnectivityDriverImpl implements ConnectivityDriver {
  @override
  Future<bool> isOnline() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet);
  }
}
