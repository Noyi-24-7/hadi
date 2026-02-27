import 'package:flutter_test/flutter_test.dart';
import 'package:hadi/features/products/domain/entities/product.dart';
import 'package:hadi/features/products/domain/entities/product_variant.dart';
import 'package:hadi/features/products/domain/usecases/resolve_variant_for_selection.dart';

void main() {
  group('currentPriceForSelection', () {
    test('uses variant price when variant selected', () {
      const product = Product(
        id: 'p1',
        storeId: 's1',
        name: 'Test',
        price: 10.0,
      );
      const variant = ProductVariant(
        id: 'v1',
        productId: 'p1',
        size: 'M',
        color: 'Red',
        priceAmount: 1500,
        quantity: 5,
      );
      final price = currentPriceForSelection(
        product: product,
        selectedVariant: variant,
      );
      expect(price, 1500);
    });

    test('uses product base price when no variant', () {
      const product = Product(
        id: 'p1',
        storeId: 's1',
        name: 'Test',
        price: 10.0,
      );
      final price = currentPriceForSelection(
        product: product,
        selectedVariant: null,
      );
      expect(price, 1000);
    });
  });
}
