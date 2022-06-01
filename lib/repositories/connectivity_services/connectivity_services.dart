import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityServices {
  final _connectivity = Connectivity();
  final connectivityStream = StreamController<ConnectivityResult>();
  ConnectivityServices() {
    _connectivity.onConnectivityChanged.listen((event) {
      connectivityStream.add(event);
    });
  }
}