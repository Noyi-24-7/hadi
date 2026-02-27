import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/pages/profile_pages/order_transaction_history_page/order_transaction_history_page_widget.dart';

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
    return DefaultAssetBundle(
      bundle: TestAssetBundle(),
      child: const MaterialApp(
        home: OrderTransactionHistoryPageWidget(),
      ),
    );
  }

  testWidgets('OrderTransactionHistoryPageWidget shows loading initially', (tester) async {
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

  testWidgets('OrderTransactionHistoryPageWidget shows error when store load fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.error('Store failure')),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load data'), findsOneWidget); // Widget uses _buildError which shows 'Failed to load data'
    expect(find.text('Store failure'), findsOneWidget);
  });

  /*
  testWidgets('OrderTransactionHistoryPageWidget loads and shows content', (tester) async {
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
      expect(find.text('Order & Transaction History'), findsOneWidget);
      
      // Filter dropdown (hint text)
      expect(find.text('Filter by'), findsOneWidget);

      // Revenue Cards (Titles)
      expect(find.text('Total Revenue'), findsOneWidget);
      expect(find.text('Total Withdrawal'), findsOneWidget);
      expect(find.text('Pending Withdrawal'), findsOneWidget);

      // Empty State
      expect(find.text('No transaction history yet'), findsOneWidget);
    });
  });
  */
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (key == 'AssetManifest.json') {
      return '{"assets/images/Total_Rev.png": ["assets/images/Total_Rev.png"], "assets/images/Total_Withdraw.png": ["assets/images/Total_Withdraw.png"], "assets/images/Pending_Withdraw.png": ["assets/images/Pending_Withdraw.png"]}';
    }
    return '';
  }

  @override
  Future<ByteData> load(String key) async {
    // 1x1 transparent pixel
    final Uint8List bytes = Uint8List.fromList([
      0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D,
      0x49, 0x48, 0x44, 0x52, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
      0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89, 0x00, 0x00, 0x00,
      0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00,
      0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49,
      0x45, 0x4E, 0x44, 0xAE, 0x42, 0x60, 0x82
    ]);
    return ByteData.view(bytes.buffer);
  }
}
