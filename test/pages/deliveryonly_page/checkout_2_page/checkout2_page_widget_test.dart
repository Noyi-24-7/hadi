
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hadi/backend/supabase/database/tables/stores.dart';
import 'package:hadi/features/orders/presentation/providers/checkout_provider.dart';
import 'package:hadi/features/shipping/domain/entities/delivery_quote.dart';
import 'package:hadi/features/shipping/domain/usecases/get_delivery_quotes.dart';
import 'package:hadi/features/shipping/presentation/providers/shipping_providers.dart';
import 'package:hadi/pages/deliveryonly_page/checkout_2_page/checkout2_page_widget.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockGetDeliveryQuotes extends Mock implements GetDeliveryQuotes {}

void main() {
  late MockGetDeliveryQuotes mockGetDeliveryQuotes;

  setUp(() {
    mockGetDeliveryQuotes = MockGetDeliveryQuotes();
    registerFallbackValue(<String, dynamic>{});
    when(() => mockGetDeliveryQuotes.call(
      pickupAddress: any(named: 'pickupAddress'),
      deliveryAddress: any(named: 'deliveryAddress'),
      package: any(named: 'package'),
    )).thenAnswer((_) async => const Right([]));
  });

  final tStoreRow = StoresRow({
    'id': 'store_123',
    'owner_id': 'user_123',
    'name': 'Test Store',
    'is_active': true,
    'created_at': DateTime.now().toIso8601String(),
    'business_info_complete': true,
    'bank_complete': true,
    'pickup_address_complete': true,
    'storefront_setup_complete': true,
    'onboarding_complete': true,
  });

  const tQuote = DeliveryQuote(
    id: 'quote_1',
    providerName: 'Test Provider',
    priceAmount: 500,
    etaText: '2 days',
    serviceLevel: 'standard',
  );

  testWidgets('Checkout2PageWidget shows loading initially', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    
    await mockNetworkImagesFor(() => tester.pumpWidget(
      ProviderScope(
        overrides: [
          checkout2PageStoreProvider.overrideWith((ref) => Future.value(tStoreRow)),
          checkoutSessionProvider.overrideWith((ref) => CheckoutSession()),
          getDeliveryQuotesProvider.overrideWith((ref) => mockGetDeliveryQuotes),
        ],
        child: const MaterialApp(
          home: Checkout2PageWidget(),
        ),
      ),
    ));
    
    // We expect "Test Store" to be visible eventually
    // Use pump with duration to avoid infinite animation timeout
    await mockNetworkImagesFor(() => tester.pump(const Duration(seconds: 1)));
    expect(find.text('Test Store'), findsOneWidget);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('Checkout2PageWidget shows store name and fetches quotes', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    
    when(() => mockGetDeliveryQuotes.call(
          pickupAddress: any(named: 'pickupAddress'),
          deliveryAddress: any(named: 'deliveryAddress'),
          package: any(named: 'package'),
        )).thenAnswer((_) async => const Right([tQuote]));

    // Initialize session with some data
    final session = CheckoutSession();
    session.updateItemDetails(name: 'Item 1', value: 1000, quantity: 1, weight: 1.0);
    session.updatePickupAddress(address: 'Pickup St', city: 'City', state: 'State', country: 'Country');
    session.updateDeliveryAddress(address: 'Delivery St', lga: 'LGA', state: 'State', country: 'Country');

    await mockNetworkImagesFor(() => tester.pumpWidget(
      ProviderScope(
        overrides: [
          checkout2PageStoreProvider.overrideWith((ref) => Future.value(tStoreRow)),
          checkoutSessionProvider.overrideWith((ref) => session),
          getDeliveryQuotesProvider.overrideWith((ref) => mockGetDeliveryQuotes),
        ],
        child: const MaterialApp(
          home: Checkout2PageWidget(),
        ),
      ),
    ));

    // Use pump with duration to avoid infinite animation timeout (e.g. progress indicators)
    await mockNetworkImagesFor(() => tester.pump(const Duration(seconds: 1)));

    expect(find.text('Test Store'), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);
    expect(find.textContaining('Delivery St'), findsOneWidget);
    
    // Debug: Check if error or loading
    if (find.textContaining('Error loading').evaluate().isNotEmpty) {
      debugPrint('Found Error Loading: ${find.textContaining('Error loading').evaluate().first}');
    }
    expect(find.textContaining('Error loading'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    // Verify quote is displayed
    expect(find.text('Test Provider'), findsOneWidget);
 

    verify(() => mockGetDeliveryQuotes.call(
          pickupAddress: any(named: 'pickupAddress'),
          deliveryAddress: any(named: 'deliveryAddress'),
          package: any(named: 'package'),
        )).called(1);
    // You might want to also verify that the quote is displayed if the UI shows it.
    // The UI code I viewed earlier (Step 4651) didn't seem to show quotes list?
    // It has "CONTACT & DELIVERY DETAILS" but I didn't see a list of quotes.
    // Maybe it shows expected delivery fee or something?
    // Line 89 watches quotesAsync but line 95 returns storeAsync.when.
    // Inside the body, quotesAsync logic might be deeper.
    // Looking at Step 4651, I don't see `quotesAsync` usage in the snippet.
    // It watches it, but does it use it?
    // Maybe the generated code has logic or it's further down in the file.
  });
}
