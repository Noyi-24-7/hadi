// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_ticket_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deliveryTicketRemoteDataSourceHash() =>
    r'bde969325be3b4c59c6ef3b7ad04d5b7dce9cbc9';

/// See also [deliveryTicketRemoteDataSource].
@ProviderFor(deliveryTicketRemoteDataSource)
final deliveryTicketRemoteDataSourceProvider =
    AutoDisposeProvider<DeliveryTicketRemoteDataSource>.internal(
  deliveryTicketRemoteDataSource,
  name: r'deliveryTicketRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deliveryTicketRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeliveryTicketRemoteDataSourceRef
    = AutoDisposeProviderRef<DeliveryTicketRemoteDataSource>;
String _$deliveryTicketRepositoryHash() =>
    r'b3897c99cd72572018194377a5df8bccc0442a2f';

/// See also [deliveryTicketRepository].
@ProviderFor(deliveryTicketRepository)
final deliveryTicketRepositoryProvider =
    AutoDisposeProvider<DeliveryTicketRepository>.internal(
  deliveryTicketRepository,
  name: r'deliveryTicketRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deliveryTicketRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DeliveryTicketRepositoryRef
    = AutoDisposeProviderRef<DeliveryTicketRepository>;
String _$createDeliveryTicketHash() =>
    r'cb91caddd628503a4a6b67bf267a7fae3e3b7576';

/// See also [createDeliveryTicket].
@ProviderFor(createDeliveryTicket)
final createDeliveryTicketProvider =
    AutoDisposeProvider<CreateDeliveryTicket>.internal(
  createDeliveryTicket,
  name: r'createDeliveryTicketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$createDeliveryTicketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateDeliveryTicketRef = AutoDisposeProviderRef<CreateDeliveryTicket>;
String _$getDeliveryTicketHash() => r'64558381535619e7030d8ae062476883c5e36974';

/// See also [getDeliveryTicket].
@ProviderFor(getDeliveryTicket)
final getDeliveryTicketProvider =
    AutoDisposeProvider<GetDeliveryTicket>.internal(
  getDeliveryTicket,
  name: r'getDeliveryTicketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDeliveryTicketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDeliveryTicketRef = AutoDisposeProviderRef<GetDeliveryTicket>;
String _$getDeliveryTicketsByStoreHash() =>
    r'724a55a430f307ef2dc28b4e1aad5b8ee5ef0111';

/// See also [getDeliveryTicketsByStore].
@ProviderFor(getDeliveryTicketsByStore)
final getDeliveryTicketsByStoreProvider =
    AutoDisposeProvider<GetDeliveryTicketsByStore>.internal(
  getDeliveryTicketsByStore,
  name: r'getDeliveryTicketsByStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDeliveryTicketsByStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDeliveryTicketsByStoreRef
    = AutoDisposeProviderRef<GetDeliveryTicketsByStore>;
String _$deliveryTicketHash() => r'c5a403144427982468c5d850ab631a7423d2fd71';

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

/// See also [deliveryTicket].
@ProviderFor(deliveryTicket)
const deliveryTicketProvider = DeliveryTicketFamily();

/// See also [deliveryTicket].
class DeliveryTicketFamily extends Family<AsyncValue<DeliveryTicket>> {
  /// See also [deliveryTicket].
  const DeliveryTicketFamily();

  /// See also [deliveryTicket].
  DeliveryTicketProvider call(
    String ticketId,
  ) {
    return DeliveryTicketProvider(
      ticketId,
    );
  }

  @override
  DeliveryTicketProvider getProviderOverride(
    covariant DeliveryTicketProvider provider,
  ) {
    return call(
      provider.ticketId,
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
  String? get name => r'deliveryTicketProvider';
}

/// See also [deliveryTicket].
class DeliveryTicketProvider extends AutoDisposeFutureProvider<DeliveryTicket> {
  /// See also [deliveryTicket].
  DeliveryTicketProvider(
    String ticketId,
  ) : this._internal(
          (ref) => deliveryTicket(
            ref as DeliveryTicketRef,
            ticketId,
          ),
          from: deliveryTicketProvider,
          name: r'deliveryTicketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deliveryTicketHash,
          dependencies: DeliveryTicketFamily._dependencies,
          allTransitiveDependencies:
              DeliveryTicketFamily._allTransitiveDependencies,
          ticketId: ticketId,
        );

  DeliveryTicketProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ticketId,
  }) : super.internal();

  final String ticketId;

  @override
  Override overrideWith(
    FutureOr<DeliveryTicket> Function(DeliveryTicketRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeliveryTicketProvider._internal(
        (ref) => create(ref as DeliveryTicketRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ticketId: ticketId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<DeliveryTicket> createElement() {
    return _DeliveryTicketProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryTicketProvider && other.ticketId == ticketId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ticketId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeliveryTicketRef on AutoDisposeFutureProviderRef<DeliveryTicket> {
  /// The parameter `ticketId` of this provider.
  String get ticketId;
}

class _DeliveryTicketProviderElement
    extends AutoDisposeFutureProviderElement<DeliveryTicket>
    with DeliveryTicketRef {
  _DeliveryTicketProviderElement(super.provider);

  @override
  String get ticketId => (origin as DeliveryTicketProvider).ticketId;
}

String _$deliveryTicketsByStoreHash() =>
    r'821507c7bead55d3f685182f4cd34187c0ae42b8';

/// See also [deliveryTicketsByStore].
@ProviderFor(deliveryTicketsByStore)
const deliveryTicketsByStoreProvider = DeliveryTicketsByStoreFamily();

/// See also [deliveryTicketsByStore].
class DeliveryTicketsByStoreFamily
    extends Family<AsyncValue<List<DeliveryTicket>>> {
  /// See also [deliveryTicketsByStore].
  const DeliveryTicketsByStoreFamily();

  /// See also [deliveryTicketsByStore].
  DeliveryTicketsByStoreProvider call(
    String storeId,
  ) {
    return DeliveryTicketsByStoreProvider(
      storeId,
    );
  }

  @override
  DeliveryTicketsByStoreProvider getProviderOverride(
    covariant DeliveryTicketsByStoreProvider provider,
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
  String? get name => r'deliveryTicketsByStoreProvider';
}

/// See also [deliveryTicketsByStore].
class DeliveryTicketsByStoreProvider
    extends AutoDisposeFutureProvider<List<DeliveryTicket>> {
  /// See also [deliveryTicketsByStore].
  DeliveryTicketsByStoreProvider(
    String storeId,
  ) : this._internal(
          (ref) => deliveryTicketsByStore(
            ref as DeliveryTicketsByStoreRef,
            storeId,
          ),
          from: deliveryTicketsByStoreProvider,
          name: r'deliveryTicketsByStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deliveryTicketsByStoreHash,
          dependencies: DeliveryTicketsByStoreFamily._dependencies,
          allTransitiveDependencies:
              DeliveryTicketsByStoreFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  DeliveryTicketsByStoreProvider._internal(
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
    FutureOr<List<DeliveryTicket>> Function(DeliveryTicketsByStoreRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeliveryTicketsByStoreProvider._internal(
        (ref) => create(ref as DeliveryTicketsByStoreRef),
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
  AutoDisposeFutureProviderElement<List<DeliveryTicket>> createElement() {
    return _DeliveryTicketsByStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryTicketsByStoreProvider && other.storeId == storeId;
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
mixin DeliveryTicketsByStoreRef
    on AutoDisposeFutureProviderRef<List<DeliveryTicket>> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _DeliveryTicketsByStoreProviderElement
    extends AutoDisposeFutureProviderElement<List<DeliveryTicket>>
    with DeliveryTicketsByStoreRef {
  _DeliveryTicketsByStoreProviderElement(super.provider);

  @override
  String get storeId => (origin as DeliveryTicketsByStoreProvider).storeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
