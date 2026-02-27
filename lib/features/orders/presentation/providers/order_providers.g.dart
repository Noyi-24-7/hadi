// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderRemoteDataSourceHash() =>
    r'f9c1778f12ac69fba581cab292b67032e829b3cd';

/// See also [orderRemoteDataSource].
@ProviderFor(orderRemoteDataSource)
final orderRemoteDataSourceProvider =
    AutoDisposeProvider<OrderRemoteDataSource>.internal(
  orderRemoteDataSource,
  name: r'orderRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderRemoteDataSourceRef
    = AutoDisposeProviderRef<OrderRemoteDataSource>;
String _$orderRepositoryHash() => r'10304d48c476cf130d56a97105f05ad6bfe883fc';

/// See also [orderRepository].
@ProviderFor(orderRepository)
final orderRepositoryProvider = AutoDisposeProvider<OrderRepository>.internal(
  orderRepository,
  name: r'orderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderRepositoryRef = AutoDisposeProviderRef<OrderRepository>;
String _$createOrderHash() => r'94db78f131ec1c8a040c4d1ae9863dc55fb2732e';

/// See also [createOrder].
@ProviderFor(createOrder)
final createOrderProvider = AutoDisposeProvider<CreateOrder>.internal(
  createOrder,
  name: r'createOrderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$createOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreateOrderRef = AutoDisposeProviderRef<CreateOrder>;
String _$getOrderHash() => r'f1099b7c9a80ae1d016a312e36eccb3cd44e36a0';

/// See also [getOrder].
@ProviderFor(getOrder)
final getOrderProvider = AutoDisposeProvider<GetOrder>.internal(
  getOrder,
  name: r'getOrderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetOrderRef = AutoDisposeProviderRef<GetOrder>;
String _$getOrdersByBuyerHash() => r'5f9d1d414b4c8a3c875acae9f21487c0e2cba8c9';

/// See also [getOrdersByBuyer].
@ProviderFor(getOrdersByBuyer)
final getOrdersByBuyerProvider = AutoDisposeProvider<GetOrdersByBuyer>.internal(
  getOrdersByBuyer,
  name: r'getOrdersByBuyerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getOrdersByBuyerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetOrdersByBuyerRef = AutoDisposeProviderRef<GetOrdersByBuyer>;
String _$getOrdersByStoreHash() => r'2f9e33ad869a7a767d8d96bc24680e3ea5a6bd56';

/// See also [getOrdersByStore].
@ProviderFor(getOrdersByStore)
final getOrdersByStoreProvider = AutoDisposeProvider<GetOrdersByStore>.internal(
  getOrdersByStore,
  name: r'getOrdersByStoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getOrdersByStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetOrdersByStoreRef = AutoDisposeProviderRef<GetOrdersByStore>;
String _$getOrderItemsHash() => r'7ac1812695893746a453571f00f26e65ee5f00c0';

/// See also [getOrderItems].
@ProviderFor(getOrderItems)
final getOrderItemsProvider = AutoDisposeProvider<GetOrderItems>.internal(
  getOrderItems,
  name: r'getOrderItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getOrderItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetOrderItemsRef = AutoDisposeProviderRef<GetOrderItems>;
String _$orderHash() => r'24b176a527e8828cda57bf8ed143c8fec7dd9fff';

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

/// See also [order].
@ProviderFor(order)
const orderProvider = OrderFamily();

/// See also [order].
class OrderFamily extends Family<AsyncValue<Order>> {
  /// See also [order].
  const OrderFamily();

  /// See also [order].
  OrderProvider call(
    String orderId,
  ) {
    return OrderProvider(
      orderId,
    );
  }

  @override
  OrderProvider getProviderOverride(
    covariant OrderProvider provider,
  ) {
    return call(
      provider.orderId,
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
  String? get name => r'orderProvider';
}

/// See also [order].
class OrderProvider extends AutoDisposeFutureProvider<Order> {
  /// See also [order].
  OrderProvider(
    String orderId,
  ) : this._internal(
          (ref) => order(
            ref as OrderRef,
            orderId,
          ),
          from: orderProvider,
          name: r'orderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderHash,
          dependencies: OrderFamily._dependencies,
          allTransitiveDependencies: OrderFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  OrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<Order> Function(OrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderProvider._internal(
        (ref) => create(ref as OrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Order> createElement() {
    return _OrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderRef on AutoDisposeFutureProviderRef<Order> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderProviderElement extends AutoDisposeFutureProviderElement<Order>
    with OrderRef {
  _OrderProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderProvider).orderId;
}

String _$ordersByBuyerHash() => r'1109827b9b01f0c333ec40e62612e65ededfca29';

/// See also [ordersByBuyer].
@ProviderFor(ordersByBuyer)
const ordersByBuyerProvider = OrdersByBuyerFamily();

/// See also [ordersByBuyer].
class OrdersByBuyerFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [ordersByBuyer].
  const OrdersByBuyerFamily();

  /// See also [ordersByBuyer].
  OrdersByBuyerProvider call(
    String buyerId,
  ) {
    return OrdersByBuyerProvider(
      buyerId,
    );
  }

  @override
  OrdersByBuyerProvider getProviderOverride(
    covariant OrdersByBuyerProvider provider,
  ) {
    return call(
      provider.buyerId,
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
  String? get name => r'ordersByBuyerProvider';
}

/// See also [ordersByBuyer].
class OrdersByBuyerProvider extends AutoDisposeFutureProvider<List<Order>> {
  /// See also [ordersByBuyer].
  OrdersByBuyerProvider(
    String buyerId,
  ) : this._internal(
          (ref) => ordersByBuyer(
            ref as OrdersByBuyerRef,
            buyerId,
          ),
          from: ordersByBuyerProvider,
          name: r'ordersByBuyerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ordersByBuyerHash,
          dependencies: OrdersByBuyerFamily._dependencies,
          allTransitiveDependencies:
              OrdersByBuyerFamily._allTransitiveDependencies,
          buyerId: buyerId,
        );

  OrdersByBuyerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.buyerId,
  }) : super.internal();

  final String buyerId;

  @override
  Override overrideWith(
    FutureOr<List<Order>> Function(OrdersByBuyerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrdersByBuyerProvider._internal(
        (ref) => create(ref as OrdersByBuyerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        buyerId: buyerId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Order>> createElement() {
    return _OrdersByBuyerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdersByBuyerProvider && other.buyerId == buyerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, buyerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrdersByBuyerRef on AutoDisposeFutureProviderRef<List<Order>> {
  /// The parameter `buyerId` of this provider.
  String get buyerId;
}

class _OrdersByBuyerProviderElement
    extends AutoDisposeFutureProviderElement<List<Order>>
    with OrdersByBuyerRef {
  _OrdersByBuyerProviderElement(super.provider);

  @override
  String get buyerId => (origin as OrdersByBuyerProvider).buyerId;
}

String _$ordersByStoreHash() => r'6c73dc6d6c3407d687d2c9194d73b3703085828b';

/// See also [ordersByStore].
@ProviderFor(ordersByStore)
const ordersByStoreProvider = OrdersByStoreFamily();

/// See also [ordersByStore].
class OrdersByStoreFamily extends Family<AsyncValue<List<Order>>> {
  /// See also [ordersByStore].
  const OrdersByStoreFamily();

  /// See also [ordersByStore].
  OrdersByStoreProvider call(
    String storeId,
  ) {
    return OrdersByStoreProvider(
      storeId,
    );
  }

  @override
  OrdersByStoreProvider getProviderOverride(
    covariant OrdersByStoreProvider provider,
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
  String? get name => r'ordersByStoreProvider';
}

/// See also [ordersByStore].
class OrdersByStoreProvider extends AutoDisposeFutureProvider<List<Order>> {
  /// See also [ordersByStore].
  OrdersByStoreProvider(
    String storeId,
  ) : this._internal(
          (ref) => ordersByStore(
            ref as OrdersByStoreRef,
            storeId,
          ),
          from: ordersByStoreProvider,
          name: r'ordersByStoreProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ordersByStoreHash,
          dependencies: OrdersByStoreFamily._dependencies,
          allTransitiveDependencies:
              OrdersByStoreFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  OrdersByStoreProvider._internal(
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
    FutureOr<List<Order>> Function(OrdersByStoreRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrdersByStoreProvider._internal(
        (ref) => create(ref as OrdersByStoreRef),
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
  AutoDisposeFutureProviderElement<List<Order>> createElement() {
    return _OrdersByStoreProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrdersByStoreProvider && other.storeId == storeId;
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
mixin OrdersByStoreRef on AutoDisposeFutureProviderRef<List<Order>> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _OrdersByStoreProviderElement
    extends AutoDisposeFutureProviderElement<List<Order>>
    with OrdersByStoreRef {
  _OrdersByStoreProviderElement(super.provider);

  @override
  String get storeId => (origin as OrdersByStoreProvider).storeId;
}

String _$orderItemsHash() => r'8e64d8433bd6a58c9a30010d017114de1ae05811';

/// See also [orderItems].
@ProviderFor(orderItems)
const orderItemsProvider = OrderItemsFamily();

/// See also [orderItems].
class OrderItemsFamily extends Family<AsyncValue<List<OrderItem>>> {
  /// See also [orderItems].
  const OrderItemsFamily();

  /// See also [orderItems].
  OrderItemsProvider call(
    String orderId,
  ) {
    return OrderItemsProvider(
      orderId,
    );
  }

  @override
  OrderItemsProvider getProviderOverride(
    covariant OrderItemsProvider provider,
  ) {
    return call(
      provider.orderId,
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
  String? get name => r'orderItemsProvider';
}

/// See also [orderItems].
class OrderItemsProvider extends AutoDisposeFutureProvider<List<OrderItem>> {
  /// See also [orderItems].
  OrderItemsProvider(
    String orderId,
  ) : this._internal(
          (ref) => orderItems(
            ref as OrderItemsRef,
            orderId,
          ),
          from: orderItemsProvider,
          name: r'orderItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderItemsHash,
          dependencies: OrderItemsFamily._dependencies,
          allTransitiveDependencies:
              OrderItemsFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  OrderItemsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  Override overrideWith(
    FutureOr<List<OrderItem>> Function(OrderItemsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderItemsProvider._internal(
        (ref) => create(ref as OrderItemsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<OrderItem>> createElement() {
    return _OrderItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderItemsProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OrderItemsRef on AutoDisposeFutureProviderRef<List<OrderItem>> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderItemsProviderElement
    extends AutoDisposeFutureProviderElement<List<OrderItem>>
    with OrderItemsRef {
  _OrderItemsProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderItemsProvider).orderId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
