// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preorder_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$preorderRemoteDataSourceHash() =>
    r'9f6aa29f4055d6be764ef7d300b0e365f65a0228';

/// See also [preorderRemoteDataSource].
@ProviderFor(preorderRemoteDataSource)
final preorderRemoteDataSourceProvider =
    AutoDisposeProvider<PreorderRemoteDataSource>.internal(
  preorderRemoteDataSource,
  name: r'preorderRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$preorderRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreorderRemoteDataSourceRef
    = AutoDisposeProviderRef<PreorderRemoteDataSource>;
String _$preorderRepositoryHash() =>
    r'5adbf9a6e32911321fb3dc062cf7573f5f247b5c';

/// See also [preorderRepository].
@ProviderFor(preorderRepository)
final preorderRepositoryProvider =
    AutoDisposeProvider<PreorderRepository>.internal(
  preorderRepository,
  name: r'preorderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$preorderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PreorderRepositoryRef = AutoDisposeProviderRef<PreorderRepository>;
String _$getPreordersByStoreHash() =>
    r'56da2524e56f458046385fa3a04d09dd9b57fd8e';

/// See also [getPreordersByStore].
@ProviderFor(getPreordersByStore)
final getPreordersByStoreProvider =
    AutoDisposeProvider<GetPreordersByStore>.internal(
  getPreordersByStore,
  name: r'getPreordersByStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getPreordersByStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPreordersByStoreRef = AutoDisposeProviderRef<GetPreordersByStore>;
String _$getPreorderHash() => r'5158bc6b9a113c6e44af6dc59baf7f351a2e22bd';

/// See also [getPreorder].
@ProviderFor(getPreorder)
final getPreorderProvider = AutoDisposeProvider<GetPreorder>.internal(
  getPreorder,
  name: r'getPreorderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPreorderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPreorderRef = AutoDisposeProviderRef<GetPreorder>;
String _$createPreorderShipmentHash() =>
    r'bc4c5d0ca210dc400acc593fec11b4f85e5a6c1c';

/// See also [createPreorderShipment].
@ProviderFor(createPreorderShipment)
final createPreorderShipmentProvider =
    AutoDisposeProvider<CreatePreorderShipment>.internal(
  createPreorderShipment,
  name: r'createPreorderShipmentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createPreorderShipmentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreatePreorderShipmentRef
    = AutoDisposeProviderRef<CreatePreorderShipment>;
String _$preordersByStoreHash() => r'6ce38d492e10da1779f02b78f64e812a4aa0321b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [preordersByStore].
@ProviderFor(preordersByStore)
const preordersByStoreProvider = PreordersByStoreFamily();

/// See also [preordersByStore].
class PreordersByStoreFamily extends Family<AsyncValue<List<PreorderRequest>>> {
  /// See also [preordersByStore].
  const PreordersByStoreFamily();

  /// See also [preordersByStore].
  PreordersByStoreProvider call(
    String storeId,
  ) {
    return PreordersByStoreProvider(
      storeId,
    );
  }

  @override
  PreordersByStoreProvider getProviderOverride(
    covariant PreordersByStoreProvider provider,
  ) {
    return call(
      provider.storeId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'preordersByStoreProvider';
}

/// See also [preordersByStore].
class PreordersByStoreProvider
    extends AutoDisposeFutureProvider<List<PreorderRequest>> {
  /// See also [preordersByStore].
  PreordersByStoreProvider(
    String storeId,
  ) : this._internal(
          (ref) => preordersByStore(
            ref as PreordersByStoreRef,
            storeId,
          ),
          from: preordersByStoreProvider,
          name: r'preordersByStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$preordersByStoreHash,
          dependencies: PreordersByStoreFamily._dependencies,
          allTransitiveDependencies:
              PreordersByStoreFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  PreordersByStoreProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storeId,
  }) : super.internal();

  final String storeId;

  @override
  Override overrideWith(
    FutureOr<List<PreorderRequest>> Function(PreordersByStoreRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PreordersByStoreProvider._internal(
        (ref) => create(ref as PreordersByStoreRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storeId: storeId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PreorderRequest>> createElement() {
    return _PreordersByStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PreordersByStoreProvider && other.storeId == storeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PreordersByStoreRef
    on AutoDisposeFutureProviderRef<List<PreorderRequest>> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _PreordersByStoreProviderElement
    extends AutoDisposeFutureProviderElement<List<PreorderRequest>>
    with PreordersByStoreRef {
  _PreordersByStoreProviderElement(super.provider);

  @override
  String get storeId => (origin as PreordersByStoreProvider).storeId;
}

String _$preorderHash() => r'eca64b9f492a5d6cbc7a86033efdfbcb793cf8cc';

/// See also [preorder].
@ProviderFor(preorder)
const preorderProvider = PreorderFamily();

/// See also [preorder].
class PreorderFamily extends Family<AsyncValue<PreorderRequest>> {
  /// See also [preorder].
  const PreorderFamily();

  /// See also [preorder].
  PreorderProvider call(
    String preorderId,
  ) {
    return PreorderProvider(
      preorderId,
    );
  }

  @override
  PreorderProvider getProviderOverride(
    covariant PreorderProvider provider,
  ) {
    return call(
      provider.preorderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'preorderProvider';
}

/// See also [preorder].
class PreorderProvider extends AutoDisposeFutureProvider<PreorderRequest> {
  /// See also [preorder].
  PreorderProvider(
    String preorderId,
  ) : this._internal(
          (ref) => preorder(
            ref as PreorderRef,
            preorderId,
          ),
          from: preorderProvider,
          name: r'preorderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$preorderHash,
          dependencies: PreorderFamily._dependencies,
          allTransitiveDependencies: PreorderFamily._allTransitiveDependencies,
          preorderId: preorderId,
        );

  PreorderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.preorderId,
  }) : super.internal();

  final String preorderId;

  @override
  Override overrideWith(
    FutureOr<PreorderRequest> Function(PreorderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PreorderProvider._internal(
        (ref) => create(ref as PreorderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        preorderId: preorderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PreorderRequest> createElement() {
    return _PreorderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PreorderProvider && other.preorderId == preorderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, preorderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PreorderRef on AutoDisposeFutureProviderRef<PreorderRequest> {
  /// The parameter `preorderId` of this provider.
  String get preorderId;
}

class _PreorderProviderElement
    extends AutoDisposeFutureProviderElement<PreorderRequest> with PreorderRef {
  _PreorderProviderElement(super.provider);

  @override
  String get preorderId => (origin as PreorderProvider).preorderId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
