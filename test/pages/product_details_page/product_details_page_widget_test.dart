import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/products/domain/entities/product.dart';
import 'package:hadi/features/products/domain/entities/product_variant.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart'
    hide productVariantsProvider;
import 'package:hadi/pages/product_details_page/product_details_page_widget.dart';
import 'package:hadi/pages/product_details_page/product_details_providers.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  const tProductId = 'prod_1';

  final tProduct = Product(
    id: tProductId,
    storeId: 'store_1',
    name: 'Test Product',
    description: 'Test Description',
    price: 150.0,
    isActive: true,
    createdAt: DateTime.now(),
    stockQuantity: 20,
  );

  const tStore = StoreEntity(
    id: 'store_1',
    name: 'Test Store',
    slug: 'test-store',
    description: 'A test store',
    isActive: true,
  );

  final List<ProductVariant> tVariants = [
    const ProductVariant(
      id: 'var_1',
      productId: tProductId,
      size: 'M',
      color: 'Red',
      priceAmount: 15500,
      quantity: 10,
      isActive: true,
    ),
    const ProductVariant(
      id: 'var_2',
      productId: tProductId,
      size: 'L',
      color: 'Blue',
      priceAmount: 16000,
      quantity: 5,
      isActive: true,
    ),
  ];

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: ProductDetailsPageWidget(productId: tProductId),
    );
  }

  testWidgets('ProductDetailsPageWidget shows specific loading indicator initially', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productByIdProvider(tProductId).overrideWith((ref) => Completer<Product>().future),
            productMediaProvider(tProductId).overrideWith((ref) => Future.value([])),
            productVariantsProvider(tProductId).overrideWith((ref) => Future.value([])),
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      // Pump a bit to allow animation to build
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('ProductDetailsPageWidget shows error when product load fails', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productByIdProvider(tProductId).overrideWith((ref) => Future.error('Product not found')),
            productMediaProvider(tProductId).overrideWith((ref) => Future.value([])),
            productVariantsProvider(tProductId).overrideWith((ref) => Future.value([])),
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Failed to load product'), findsOneWidget);
      expect(find.text('Product not found'), findsOneWidget);
  });

  testWidgets('ProductDetailsPageWidget displays product info correctly', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productByIdProvider(tProductId).overrideWith((ref) => Future.value(tProduct)),
            productMediaProvider(tProductId).overrideWith((ref) => Future.value([])), // Empty media
            productVariantsProvider(tProductId).overrideWith((ref) => Future.value(tVariants)),
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      // Product Info
      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Stock: 20'), findsOneWidget);

      // Variants
      expect(find.text('Variants'), findsOneWidget);
      expect(find.text('M - Red'), findsOneWidget);
      expect(find.text('L - Blue'), findsOneWidget);

      // Since media is empty, it should show default placeholder
      expect(find.byIcon(Icons.image), findsOneWidget);
    });
  });

  testWidgets('ProductDetailsPageWidget shows variants section empty if no variants', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            productByIdProvider(tProductId).overrideWith((ref) => Future.value(tProduct)),
            productMediaProvider(tProductId).overrideWith((ref) => Future.value([])),
            productVariantsProvider(tProductId).overrideWith((ref) => Future.value([])), // No variants
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Variants'), findsNothing);
    });
  });
}
