// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internetConnectionCheckerHash() =>
    r'6f1e3f77487f5de693ca464b0caa361ae30eeb6d';

/// Provider for InternetConnectionChecker instance.
///
/// Copied from [internetConnectionChecker].
@ProviderFor(internetConnectionChecker)
final internetConnectionCheckerProvider =
    AutoDisposeProvider<InternetConnectionChecker>.internal(
  internetConnectionChecker,
  name: r'internetConnectionCheckerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$internetConnectionCheckerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InternetConnectionCheckerRef
    = AutoDisposeProviderRef<InternetConnectionChecker>;
String _$networkInfoHash() => r'c7be11021eb1211be616f3525196c0573f5b0154';

/// Provider for NetworkInfo implementation.
/// Use this in repositories to check network connectivity.
///
/// Copied from [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = AutoDisposeProvider<NetworkInfo>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkInfoRef = AutoDisposeProviderRef<NetworkInfo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
