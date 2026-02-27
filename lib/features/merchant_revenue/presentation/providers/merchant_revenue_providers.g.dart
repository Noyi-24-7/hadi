// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_revenue_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$merchantRevenueRemoteDataSourceHash() =>
    r'c96d56e668a323a1b766f73f72bab6bd4af0c442';

/// See also [merchantRevenueRemoteDataSource].
@ProviderFor(merchantRevenueRemoteDataSource)
final merchantRevenueRemoteDataSourceProvider =
    AutoDisposeProvider<MerchantRevenueRemoteDataSource>.internal(
  merchantRevenueRemoteDataSource,
  name: r'merchantRevenueRemoteDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$merchantRevenueRemoteDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MerchantRevenueRemoteDataSourceRef
    = AutoDisposeProviderRef<MerchantRevenueRemoteDataSource>;
String _$merchantRevenueRepositoryHash() =>
    r'a3d34ff8e87cd40a2cd297898a0e4d573fb104f6';

/// See also [merchantRevenueRepository].
@ProviderFor(merchantRevenueRepository)
final merchantRevenueRepositoryProvider =
    AutoDisposeProvider<MerchantRevenueRepository>.internal(
  merchantRevenueRepository,
  name: r'merchantRevenueRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$merchantRevenueRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MerchantRevenueRepositoryRef
    = AutoDisposeProviderRef<MerchantRevenueRepository>;
String _$getRevenueStatsHash() => r'5a6162e263e8d9ba096db63aed5b6327bbc52fe1';

/// See also [getRevenueStats].
@ProviderFor(getRevenueStats)
final getRevenueStatsProvider = AutoDisposeProvider<GetRevenueStats>.internal(
  getRevenueStats,
  name: r'getRevenueStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getRevenueStatsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetRevenueStatsRef = AutoDisposeProviderRef<GetRevenueStats>;
String _$getTransactionsHash() => r'699e924bf56f5e1a8c1d68f2dea28e5a82582147';

/// See also [getTransactions].
@ProviderFor(getTransactions)
final getTransactionsProvider = AutoDisposeProvider<GetTransactions>.internal(
  getTransactions,
  name: r'getTransactionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTransactionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTransactionsRef = AutoDisposeProviderRef<GetTransactions>;
String _$getPayoutsHash() => r'7bc7a42c17ec37133c5b0dde6e95fc10c2c21c43';

/// See also [getPayouts].
@ProviderFor(getPayouts)
final getPayoutsProvider = AutoDisposeProvider<GetPayouts>.internal(
  getPayouts,
  name: r'getPayoutsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPayoutsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetPayoutsRef = AutoDisposeProviderRef<GetPayouts>;
String _$revenueStatsHash() => r'6bbbfd641cb6b3cff7898d9741b804445571c55e';

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

/// See also [revenueStats].
@ProviderFor(revenueStats)
const revenueStatsProvider = RevenueStatsFamily();

/// See also [revenueStats].
class RevenueStatsFamily extends Family<AsyncValue<RevenueStats>> {
  /// See also [revenueStats].
  const RevenueStatsFamily();

  /// See also [revenueStats].
  RevenueStatsProvider call(
    String storeId,
  ) {
    return RevenueStatsProvider(
      storeId,
    );
  }

  @override
  RevenueStatsProvider getProviderOverride(
    covariant RevenueStatsProvider provider,
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
  String? get name => r'revenueStatsProvider';
}

/// See also [revenueStats].
class RevenueStatsProvider extends AutoDisposeFutureProvider<RevenueStats> {
  /// See also [revenueStats].
  RevenueStatsProvider(
    String storeId,
  ) : this._internal(
          (ref) => revenueStats(
            ref as RevenueStatsRef,
            storeId,
          ),
          from: revenueStatsProvider,
          name: r'revenueStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$revenueStatsHash,
          dependencies: RevenueStatsFamily._dependencies,
          allTransitiveDependencies:
              RevenueStatsFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  RevenueStatsProvider._internal(
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
    FutureOr<RevenueStats> Function(RevenueStatsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RevenueStatsProvider._internal(
        (ref) => create(ref as RevenueStatsRef),
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
  AutoDisposeFutureProviderElement<RevenueStats> createElement() {
    return _RevenueStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RevenueStatsProvider && other.storeId == storeId;
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
mixin RevenueStatsRef on AutoDisposeFutureProviderRef<RevenueStats> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _RevenueStatsProviderElement
    extends AutoDisposeFutureProviderElement<RevenueStats>
    with RevenueStatsRef {
  _RevenueStatsProviderElement(super.provider);

  @override
  String get storeId => (origin as RevenueStatsProvider).storeId;
}

String _$transactionsHash() => r'bd9d70c30c44960b3ac8178e57d1ede0dbcafbcf';

/// See also [transactions].
@ProviderFor(transactions)
const transactionsProvider = TransactionsFamily();

/// See also [transactions].
class TransactionsFamily extends Family<AsyncValue<List<Transaction>>> {
  /// See also [transactions].
  const TransactionsFamily();

  /// See also [transactions].
  TransactionsProvider call(
    String storeId, {
    String? type,
  }) {
    return TransactionsProvider(
      storeId,
      type: type,
    );
  }

  @override
  TransactionsProvider getProviderOverride(
    covariant TransactionsProvider provider,
  ) {
    return call(
      provider.storeId,
      type: provider.type,
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
  String? get name => r'transactionsProvider';
}

/// See also [transactions].
class TransactionsProvider
    extends AutoDisposeFutureProvider<List<Transaction>> {
  /// See also [transactions].
  TransactionsProvider(
    String storeId, {
    String? type,
  }) : this._internal(
          (ref) => transactions(
            ref as TransactionsRef,
            storeId,
            type: type,
          ),
          from: transactionsProvider,
          name: r'transactionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$transactionsHash,
          dependencies: TransactionsFamily._dependencies,
          allTransitiveDependencies:
              TransactionsFamily._allTransitiveDependencies,
          storeId: storeId,
          type: type,
        );

  TransactionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.storeId,
    required this.type,
  }) : super.internal();

  final String storeId;
  final String? type;

  @override
  Override overrideWith(
    FutureOr<List<Transaction>> Function(TransactionsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TransactionsProvider._internal(
        (ref) => create(ref as TransactionsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        storeId: storeId,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Transaction>> createElement() {
    return _TransactionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionsProvider &&
        other.storeId == storeId &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, storeId.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TransactionsRef on AutoDisposeFutureProviderRef<List<Transaction>> {
  /// The parameter `storeId` of this provider.
  String get storeId;

  /// The parameter `type` of this provider.
  String? get type;
}

class _TransactionsProviderElement
    extends AutoDisposeFutureProviderElement<List<Transaction>>
    with TransactionsRef {
  _TransactionsProviderElement(super.provider);

  @override
  String get storeId => (origin as TransactionsProvider).storeId;
  @override
  String? get type => (origin as TransactionsProvider).type;
}

String _$payoutsHash() => r'706a54a45bed90a4eb3b1e5b7e3d83cc57ba7d50';

/// See also [payouts].
@ProviderFor(payouts)
const payoutsProvider = PayoutsFamily();

/// See also [payouts].
class PayoutsFamily extends Family<AsyncValue<List<Payout>>> {
  /// See also [payouts].
  const PayoutsFamily();

  /// See also [payouts].
  PayoutsProvider call(
    String storeId,
  ) {
    return PayoutsProvider(
      storeId,
    );
  }

  @override
  PayoutsProvider getProviderOverride(
    covariant PayoutsProvider provider,
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
  String? get name => r'payoutsProvider';
}

/// See also [payouts].
class PayoutsProvider extends AutoDisposeFutureProvider<List<Payout>> {
  /// See also [payouts].
  PayoutsProvider(
    String storeId,
  ) : this._internal(
          (ref) => payouts(
            ref as PayoutsRef,
            storeId,
          ),
          from: payoutsProvider,
          name: r'payoutsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$payoutsHash,
          dependencies: PayoutsFamily._dependencies,
          allTransitiveDependencies: PayoutsFamily._allTransitiveDependencies,
          storeId: storeId,
        );

  PayoutsProvider._internal(
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
    FutureOr<List<Payout>> Function(PayoutsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PayoutsProvider._internal(
        (ref) => create(ref as PayoutsRef),
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
  AutoDisposeFutureProviderElement<List<Payout>> createElement() {
    return _PayoutsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PayoutsProvider && other.storeId == storeId;
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
mixin PayoutsRef on AutoDisposeFutureProviderRef<List<Payout>> {
  /// The parameter `storeId` of this provider.
  String get storeId;
}

class _PayoutsProviderElement
    extends AutoDisposeFutureProviderElement<List<Payout>> with PayoutsRef {
  _PayoutsProviderElement(super.provider);

  @override
  String get storeId => (origin as PayoutsProvider).storeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
