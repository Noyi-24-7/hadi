import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product.dart';
import '../entities/product_variant.dart';
import '../repositories/product_repository.dart';

/// Returns the single variant matching productId + size + color, or failure if not found/out of stock.
/// Business rule: one variant per (product_id, size, color).
class ResolveVariantForSelection {
  ResolveVariantForSelection(this._repository);

  final ProductRepository _repository;

  Future<Either<Failure, ProductVariant>> call({
    required String productId,
    String? size,
    String? color,
  }) async {
    final result = await _repository.getVariantsByProductId(productId);
    return result.fold(left, (variants) {
      final match = variants.where((v) {
        final sizeMatch = (size == null || size.isEmpty) ? (v.size == null || v.size!.isEmpty) : v.size == size;
        final colorMatch = (color == null || color.isEmpty) ? (v.color == null || v.color!.isEmpty) : v.color == color;
        return sizeMatch && colorMatch;
      }).toList();
      if (match.isEmpty) return left(const ValidationFailure('Variant not found'));
      final v = match.first;
      if (v.isOutOfStock) return left(const ValidationFailure('Variant out of stock'));
      return right(v);
    });
  }
}

/// Returns current price in minor units (e.g. kobo) for display: variant price if variant selected, else product base price.
int currentPriceForSelection({
  required Product product,
  ProductVariant? selectedVariant,
}) {
  if (selectedVariant != null) return selectedVariant.priceAmount;
  return (product.price * 100).round();
}
