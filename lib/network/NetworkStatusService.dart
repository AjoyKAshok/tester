import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusService extends ChangeNotifier {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();
  bool online = false;

  NetworkStatusService() {
    Connectivity().onConnectivityChanged.listen((status) {
      networkStatusController.add(_getNetworkStatus(status));
    });
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    if (status == ConnectivityResult.mobile ||
        status == ConnectivityResult.wifi) {
      online = true;

      notifyListeners();

      return NetworkStatus.Online;
    } else {
      online = false;
      notifyListeners();
      return NetworkStatus.Offline;
    }
  }
}
