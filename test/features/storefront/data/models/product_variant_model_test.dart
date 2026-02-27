import 'package:flutter_test/flutter_test.dart';
import 'package:hadi/features/storefront/data/models/product_variant_model.dart';
import 'package:hadi/features/products/domain/entities/product_variant.dart';

void main() {
  const tProductVariantModel = ProductVariantModel(
    id: 'variant1',
    productId: 'product1',
    size: 'M',
    color: 'Red',
    priceAmount: 15000, // 150.00 * 100 kobo/cents
    quantity: 10,
    isActive: true,
  );

  test('should be a subclass of ProductVariant entity', () async {
    expect(tProductVariantModel, isA<ProductVariant>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      final Map<String, dynamic> jsonMap = {
        'id': 'variant1',
        'product_id': 'product1',
        'size': 'M',
        'color': 'Red',
        'price_amount': 15000,
        'quantity': 10,
        'is_active': true,
      };

      final result = ProductVariantModel.fromJson(jsonMap);

      expect(result, tProductVariantModel);
    });

     test('should return a valid model when price is double (unexpected but handled by num cast)', () async {
      final Map<String, dynamic> jsonMap = {
        'id': 'variant1',
        'product_id': 'product1',
        'size': 'M',
        'color': 'Red',
        'price_amount': 15000.0, // double
        'quantity': 10,
        'is_active': true,
      };

      final result = ProductVariantModel.fromJson(jsonMap);

      expect(result, tProductVariantModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tProductVariantModel.toJson();

      final expectedMap = {
        'id': 'variant1',
        'product_id': 'product1',
        'size': 'M',
        'color': 'Red',
        'price_amount': 15000,
        'quantity': 10,
        'is_active': true,
      };

      expect(result, expectedMap);
    });
  });
}
