import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'network_info.dart';

part 'network_info_provider.g.dart';

/// Provider for InternetConnectionChecker instance.
@riverpod
InternetConnectionChecker internetConnectionChecker(
  InternetConnectionCheckerRef ref,
) {
  return InternetConnectionChecker.createInstance();
}

/// Provider for NetworkInfo implementation.
/// Use this in repositories to check network connectivity.
@riverpod
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfoImpl(
    ref.watch(internetConnectionCheckerProvider),
  );
}
