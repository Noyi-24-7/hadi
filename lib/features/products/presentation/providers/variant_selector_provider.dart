import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/product_variant.dart';
import 'product_providers.dart';

part 'variant_selector_provider.freezed.dart';
part 'variant_selector_provider.g.dart';

/// State for size/color selection and resolved variant + price.
@freezed
class VariantSelectorState with _$VariantSelectorState {
  const factory VariantSelectorState({
    String? selectedSize,
    String? selectedColor,
    ProductVariant? resolvedVariant,
    Product? product,
  }) = _VariantSelectorState;

  const VariantSelectorState._();

  int get currentPriceAmount {
    final prod = this.product;
    if (prod == null) return 0;
    final variant = resolvedVariant;
    return variant != null
        ? variant.priceAmount
        : (prod.price * 100).round();
  }
}

/// Holds selection (size/color) per product. Pass productId when watching.
@riverpod
class VariantSelector extends _$VariantSelector {
  @override
  VariantSelectorState build(String productId) {
    // Load product
    ref.listen(productProvider(productId), (prev, next) {
      next.when(
        data: (product) => state = state.copyWith(product: product),
        loading: () {},
        error: (_, __) {},
      );
    });

    return const VariantSelectorState();
  }

  void selectSize(String? size) {
    state = state.copyWith(selectedSize: size);
    _resolveVariant();
  }

  void selectColor(String? color) {
    state = state.copyWith(selectedColor: color);
    _resolveVariant();
  }

  Future<void> _resolveVariant() async {
    final result = await ref.read(resolveVariantForSelectionProvider).call(
          productId: productId,
          size: state.selectedSize,
          color: state.selectedColor,
        );
    result.fold(
      (_) => state = state.copyWith(resolvedVariant: null),
      (variant) => state = state.copyWith(resolvedVariant: variant),
    );
  }
}
