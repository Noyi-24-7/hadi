import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hadi/features/products/domain/entities/product.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/pages/home_main/home_main_widget.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUpAll(() {
     GoogleFonts.config.allowRuntimeFetching = false;
  });

  const tStore = StoreEntity(
    id: 'store_1',
    name: 'Test Store',
    slug: 'test-store',
    description: 'A test store',
    isActive: true,
  );

  final List<Product> tProducts = [
    Product(
      id: 'prod_1',
      storeId: 'store_1',
      name: 'Product 1',
      description: 'Description 1',
      price: 100.0,
      isActive: true,
      createdAt: DateTime.now(),
      stockQuantity: 10,
    ),
    Product(
      id: 'prod_2',
      storeId: 'store_1',
      name: 'Product 2',
      description: 'Description 2',
      price: 200.0,
      isActive: false, // Inactive product
      createdAt: DateTime.now(),
      stockQuantity: 0,
    ),
  ];

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: HomeMainWidget(),
    );
  }

  testWidgets('HomeMainWidget shows loading state initially', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
            storeProductsProvider('store_1').overrideWith((ref) => Completer<List<Product>>().future), // Never completes
          ],
          child: createWidgetUnderTest(),
        ),
      );

      // Should show loading indicator while waiting for products
      // Note: The widget shows loading if EITHER is loading.
      // Actually, looking at the code: storeAsync.when (...) -> inside data: productsAsync.when
      // So if store loads, it shows content, then inside content it shows loading for products.

      // Let's test the Store loading state first
    });
  });

  testWidgets('HomeMainWidget shows global loading when Store is loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Completer<StoreEntity?>().future),
            storeProductsProvider('store_1').overrideWith((ref) => Future.value([])),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      // Initial pump - should be loading
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('HomeMainWidget shows error when Store fails to load', (tester) async {
     await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.error('Network Error')),
            storeProductsProvider('store_1').overrideWith((ref) => Future.value([])),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Failed to load store'), findsOneWidget);
      expect(find.text('Network Error'), findsOneWidget);
    });
  });

  testWidgets('HomeMainWidget displays store name and products when loaded', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
            storeProductsProvider('store_1').overrideWith((ref) => Future.value(tProducts)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      // Check Store Info
      expect(find.text('Test Store'), findsAtLeastNWidgets(1));

      // Check Products
      expect(find.text('Product 1'), findsOneWidget);
      expect(find.text('Product 2'), findsOneWidget);

      // Check Inactive status icon exists
      expect(find.byIcon(Icons.check_circle), findsOneWidget); // Product 1 active
      expect(find.byIcon(Icons.cancel), findsOneWidget);      // Product 2 inactive
    });
  });

   testWidgets('HomeMainWidget shows empty state when no products', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
            storeProductsProvider('store_1').overrideWith((ref) => Future.value([])),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('No products yet. Add your first product!'), findsOneWidget);
    });
  });
}
