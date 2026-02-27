import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Interface for checking network connectivity.
/// Used by repositories to determine whether to fetch from remote or cache.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] using internet_connection_checker package.
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
