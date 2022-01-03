import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Future<ConnectivityResult> dataConnectionChecker;

  NetworkInfoImpl({required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected =>
      dataConnectionChecker.then((connectivityResult) {
        if (connectivityResult != ConnectivityResult.none) {
          return true;
        } else {
          return false;
        }
      });
}