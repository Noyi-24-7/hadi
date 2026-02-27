import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/pages/pre_orders_pages/preorders_page/preorders_page_widget.dart';
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
      home: PreordersPageWidget(),
    );
  }

  testWidgets('PreordersPageWidget shows loading initially', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Completer<StoreEntity?>().future),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('PreordersPageWidget shows error when store load fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.error('Store failure')),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load store'), findsOneWidget);
    expect(find.text('Store failure'), findsOneWidget);
  });

  testWidgets('PreordersPageWidget loads and shows UI elements', (tester) async {
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

      // Header check
      expect(find.text('Test Store'), findsAtLeastNWidgets(1));
      // Page Title 'Pre-Orders' appears as title and in toggle button
      expect(find.text('Pre-Orders'), findsNWidgets(2));

      // Toggle buttons
      expect(find.text('Pre-Order Items'), findsOneWidget);

      // Tabs
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('Requested'), findsOneWidget);
      expect(find.text('Tracking'), findsOneWidget);

      // Default view is Pending tab empty state
      expect(find.text('You do not have any pending pre-orders yet'), findsOneWidget);
    });
  });

  testWidgets('PreordersPageWidget toggles view', (tester) async {
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

      // Tap 'Pre-Order Items'
      await tester.tap(find.text('Pre-Order Items'));
      await tester.pumpAndSettle();

      // Check content changed
      expect(find.text('You do not have any pre-order items yet'), findsOneWidget);
      // Tabs should be gone/hidden
      expect(find.text('Pending'), findsNothing);

      // Tap 'Pre-Orders' back (the toggle button, not the title)
      await tester.tap(find.text('Pre-Orders').last);
      await tester.pumpAndSettle();
    });
  });
}
