// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipping_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shippingRemoteDataSourceHash() =>
    r'd35594b1ff63b1df21200eba1f64c7281344b572';

/// See also [shippingRemoteDataSource].
@ProviderFor(shippingRemoteDataSource)
final shippingRemoteDataSourceProvider =
    AutoDisposeProvider<ShippingRemoteDataSource>.internal(
  shippingRemoteDataSource,
  name: r'shippingRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shippingRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShippingRemoteDataSourceRef
    = AutoDisposeProviderRef<ShippingRemoteDataSource>;
String _$shippingRepositoryHash() =>
    r'63268c1c558ef6c2c2a625d557b141309a53a477';

/// See also [shippingRepository].
@ProviderFor(shippingRepository)
final shippingRepositoryProvider =
    AutoDisposeProvider<ShippingRepository>.internal(
  shippingRepository,
  name: r'shippingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$shippingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShippingRepositoryRef = AutoDisposeProviderRef<ShippingRepository>;
String _$getDeliveryQuotesHash() => r'7597a97e7f5089157b95d94d8f6b8e8bcd621233';

/// See also [getDeliveryQuotes].
@ProviderFor(getDeliveryQuotes)
final getDeliveryQuotesProvider =
    AutoDisposeProvider<GetDeliveryQuotes>.internal(
  getDeliveryQuotes,
  name: r'getDeliveryQuotesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getDeliveryQuotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetDeliveryQuotesRef = AutoDisposeProviderRef<GetDeliveryQuotes>;
String _$deliveryQuotesHash() => r'17c36526cd3541fdc015d30d6d5cbae5bc057474';

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

/// See also [deliveryQuotes].
@ProviderFor(deliveryQuotes)
const deliveryQuotesProvider = DeliveryQuotesFamily();

/// See also [deliveryQuotes].
class DeliveryQuotesFamily extends Family<AsyncValue<List<DeliveryQuote>>> {
  /// See also [deliveryQuotes].
  const DeliveryQuotesFamily();

  /// See also [deliveryQuotes].
  DeliveryQuotesProvider call(
    DeliveryQuotesParams params,
  ) {
    return DeliveryQuotesProvider(
      params,
    );
  }

  @override
  DeliveryQuotesProvider getProviderOverride(
    covariant DeliveryQuotesProvider provider,
  ) {
    return call(
      provider.params,
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
  String? get name => r'deliveryQuotesProvider';
}

/// See also [deliveryQuotes].
class DeliveryQuotesProvider
    extends AutoDisposeFutureProvider<List<DeliveryQuote>> {
  /// See also [deliveryQuotes].
  DeliveryQuotesProvider(
    DeliveryQuotesParams params,
  ) : this._internal(
          (ref) => deliveryQuotes(
            ref as DeliveryQuotesRef,
            params,
          ),
          from: deliveryQuotesProvider,
          name: r'deliveryQuotesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deliveryQuotesHash,
          dependencies: DeliveryQuotesFamily._dependencies,
          allTransitiveDependencies:
              DeliveryQuotesFamily._allTransitiveDependencies,
          params: params,
        );

  DeliveryQuotesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.params,
  }) : super.internal();

  final DeliveryQuotesParams params;

  @override
  Override overrideWith(
    FutureOr<List<DeliveryQuote>> Function(DeliveryQuotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeliveryQuotesProvider._internal(
        (ref) => create(ref as DeliveryQuotesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        params: params,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DeliveryQuote>> createElement() {
    return _DeliveryQuotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeliveryQuotesProvider && other.params == params;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, params.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DeliveryQuotesRef on AutoDisposeFutureProviderRef<List<DeliveryQuote>> {
  /// The parameter `params` of this provider.
  DeliveryQuotesParams get params;
}

class _DeliveryQuotesProviderElement
    extends AutoDisposeFutureProviderElement<List<DeliveryQuote>>
    with DeliveryQuotesRef {
  _DeliveryQuotesProviderElement(super.provider);

  @override
  DeliveryQuotesParams get params => (origin as DeliveryQuotesProvider).params;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
