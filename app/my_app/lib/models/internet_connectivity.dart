import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';


Future<bool> getConnectivity() async {
  final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
  if(connectivityResult.contains(ConnectivityResult.mobile) || connectivityResult.contains(ConnectivityResult.wifi) || connectivityResult.contains(ConnectivityResult.ethernet) || connectivityResult.contains(ConnectivityResult.vpn)) {
    return true;
  }
  return false;
}

StreamSubscription<List<ConnectivityResult>> subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
  // Received changes in available connectivity types!
});