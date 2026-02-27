// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_selector_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$variantSelectorHash() => r'69c066aeea7a56a8cd396c9750d9c1902bf3223c';

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

abstract class _$VariantSelector
    extends BuildlessAutoDisposeNotifier<VariantSelectorState> {
  late final String productId;

  VariantSelectorState build(
    String productId,
  );
}

/// Holds selection (size/color) per product. Pass productId when watching.
///
/// Copied from [VariantSelector].
@ProviderFor(VariantSelector)
const variantSelectorProvider = VariantSelectorFamily();

/// Holds selection (size/color) per product. Pass productId when watching.
///
/// Copied from [VariantSelector].
class VariantSelectorFamily extends Family<VariantSelectorState> {
  /// Holds selection (size/color) per product. Pass productId when watching.
  ///
  /// Copied from [VariantSelector].
  const VariantSelectorFamily();

  /// Holds selection (size/color) per product. Pass productId when watching.
  ///
  /// Copied from [VariantSelector].
  VariantSelectorProvider call(
    String productId,
  ) {
    return VariantSelectorProvider(
      productId,
    );
  }

  @override
  VariantSelectorProvider getProviderOverride(
    covariant VariantSelectorProvider provider,
  ) {
    return call(
      provider.productId,
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
  String? get name => r'variantSelectorProvider';
}

/// Holds selection (size/color) per product. Pass productId when watching.
///
/// Copied from [VariantSelector].
class VariantSelectorProvider extends AutoDisposeNotifierProviderImpl<
    VariantSelector, VariantSelectorState> {
  /// Holds selection (size/color) per product. Pass productId when watching.
  ///
  /// Copied from [VariantSelector].
  VariantSelectorProvider(
    String productId,
  ) : this._internal(
          () => VariantSelector()..productId = productId,
          from: variantSelectorProvider,
          name: r'variantSelectorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$variantSelectorHash,
          dependencies: VariantSelectorFamily._dependencies,
          allTransitiveDependencies:
              VariantSelectorFamily._allTransitiveDependencies,
          productId: productId,
        );

  VariantSelectorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  VariantSelectorState runNotifierBuild(
    covariant VariantSelector notifier,
  ) {
    return notifier.build(
      productId,
    );
  }

  @override
  Override overrideWith(VariantSelector Function() create) {
    return ProviderOverride(
      origin: this,
      override: VariantSelectorProvider._internal(
        () => create()..productId = productId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<VariantSelector, VariantSelectorState>
      createElement() {
    return _VariantSelectorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VariantSelectorProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VariantSelectorRef
    on AutoDisposeNotifierProviderRef<VariantSelectorState> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _VariantSelectorProviderElement
    extends AutoDisposeNotifierProviderElement<VariantSelector,
        VariantSelectorState> with VariantSelectorRef {
  _VariantSelectorProviderElement(super.provider);

  @override
  String get productId => (origin as VariantSelectorProvider).productId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
