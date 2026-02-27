import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/pages/deliveryonly_page/deliveryonly_page/deliveryonly_page_widget.dart';
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

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: DeliveryonlyPageWidget(),
    );
  }

  testWidgets('DeliveryonlyPageWidget shows loading initially', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Completer<StoreEntity>().future),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('DeliveryonlyPageWidget shows error when store load fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.error('Store failure')),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load data'), findsOneWidget); 
    expect(find.text('Store failure'), findsOneWidget);
  });

  testWidgets('DeliveryonlyPageWidget loads and shows content', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      // Header
      expect(find.text('Delivery'), findsOneWidget);
      expect(find.text('Test Store'), findsOneWidget);

      // Toggles
      expect(find.text('Ongoing'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);

      // Default state (Ongoing)
      expect(find.text('No ongoing deliveries'), findsOneWidget);
      expect(find.text('No completed deliveries'), findsNothing);
    });
  });

  testWidgets('DeliveryonlyPageWidget toggles view', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      // Tap 'Completed'
      await tester.tap(find.text('Completed'));
      await tester.pumpAndSettle();

      expect(find.text('No completed deliveries'), findsOneWidget);
      expect(find.text('No ongoing deliveries'), findsNothing);

      // Tap 'Ongoing'
      await tester.tap(find.text('Ongoing'));
      await tester.pumpAndSettle();

      expect(find.text('No ongoing deliveries'), findsOneWidget);
    });
  });
}
