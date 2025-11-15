import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isconnetted() async {
    return throw UnimplementedError('');
  }
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;
  const NetworkInfoImpl(this.connectivity);
  @override
  Future<bool> isconnetted() async {
    await connectivity.checkConnectivity();
    return Future.value(true);
  }
}
