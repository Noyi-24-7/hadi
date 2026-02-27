import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/features/orders/presentation/providers/checkout_provider.dart';
import 'package:hadi/pages/deliveryonly_page/create_delivery_ticket_page/create_delivery_ticket_page_widget.dart';
import 'package:hadi/pages/personal_business_information/add_pickup_address_page/add_pickup_address_page_widget.dart';
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

  Widget createWidgetUnderTest(ProviderContainer container) {
     final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const CreateDeliveryTicketPageWidget(),
        ),
        GoRoute(
          name: AddPickupAddressPageWidget.routeName,
          path: '/addPickup',
          builder: (context, state) => const Scaffold(body: Text('Add Pickup Page')),
        ),
      ],
    );

    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  testWidgets('CreateDeliveryTicketPageWidget shows loading initially', (tester) async {
    final container = ProviderContainer(
      overrides: [
        myStoreProvider.overrideWith((ref) => Completer<StoreEntity>().future),
        checkoutSessionProvider, // Use real
      ],
    );
     addTearDown(container.dispose);

    await tester.pumpWidget(createWidgetUnderTest(container));

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('CreateDeliveryTicketPageWidget shows error when store load fails', (tester) async {
    final container = ProviderContainer(
      overrides: [
        myStoreProvider.overrideWith((ref) => Future.error('Store failure')),
        checkoutSessionProvider,
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(createWidgetUnderTest(container));

    await tester.pumpAndSettle();
    expect(find.text('Failed to load data'), findsOneWidget);
    expect(find.text('Store failure'), findsOneWidget);
  });

  testWidgets('CreateDeliveryTicketPageWidget loads and submits form', (tester) async {
    final container = ProviderContainer(
      overrides: [
        myStoreProvider.overrideWith((ref) => Future.value(tStore)),
        checkoutSessionProvider,
      ],
    );
    addTearDown(container.dispose);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest(container));
      await tester.pumpAndSettle();

      // Header
      expect(find.text('Create Delivery Ticket'), findsOneWidget);
      expect(find.text('Test Store'), findsOneWidget);

      // Fill Form
      // "Item Name" is the label text outside. "eg. Nike Dunks" is hint.
      // Widget structure: Column(Text('Item Name'), TextFormField(...)). 
      // So find.widgetWithText(TextFormField, 'Item Name') might fail if label is outside.
      // We can find by hint text.
      await tester.enterText(find.widgetWithText(TextFormField, 'eg. Nike Dunks'), 'My Delivery Item');
      
      await tester.enterText(find.widgetWithText(TextFormField, '₦0.00'), '5000');
      await tester.enterText(find.widgetWithText(TextFormField, '0'), '2');
      await tester.enterText(find.widgetWithText(TextFormField, '0.0'), '1.5');
      
      // Tap Create Button
      await tester.tap(find.text('Create Ticket'));
      await tester.pumpAndSettle(); // Navigate

      // Verify Navigation
      expect(find.text('Add Pickup Page'), findsOneWidget);

      // Verify State Update
      final session = container.read(checkoutSessionProvider);
      expect(session.itemName, 'My Delivery Item');
      expect(session.itemValue, 5000.0);
      expect(session.itemQuantity, 2);
      expect(session.itemWeight, 1.5);
    });
  });

  testWidgets('CreateDeliveryTicketPageWidget shows snackbar if item name empty', (tester) async {
    final container = ProviderContainer(
      overrides: [
        myStoreProvider.overrideWith((ref) => Future.value(tStore)),
        checkoutSessionProvider,
      ],
    );
    addTearDown(container.dispose);

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createWidgetUnderTest(container));
      await tester.pumpAndSettle();

      // Tap Create Button without entering name
      await tester.tap(find.text('Create Ticket'));
      await tester.pump(); // SnackBar shows

      expect(find.text('Please enter item name'), findsOneWidget);
      expect(find.text('Add Pickup Page'), findsNothing); // Did not navigate
    });
  });
}
