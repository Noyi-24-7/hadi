import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/auth/domain/entities/profile.dart';
import 'package:hadi/features/auth/presentation/providers/auth_providers.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/pages/profile_pages/profile_page/profile_page_widget.dart';
import 'package:network_image_mock/network_image_mock.dart';

// Mock FFAppState if needed, but for now we'll assume default behavior won't crash
// unless updated.

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

  const tProfile = Profile(
    id: 'user_1',
    role: 'merchant',
    email: 'test@example.com',
    fullName: 'Test User',
    profileImageUrl: 'https://example.com/profile.jpg',
  );

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: ProfilePageWidget(),
    );
  }

  testWidgets('ProfilePageWidget shows loading initially (Store loading)', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Completer<StoreEntity?>().future),
          currentProfileProvider.overrideWith((ref) => Future.value(tProfile)),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('ProfilePageWidget shows loading when Profile loading', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          currentProfileProvider.overrideWith((ref) => Completer<Profile?>().future),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('ProfilePageWidget shows error when Store load fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.error('Store Error')),
          currentProfileProvider.overrideWith((ref) => Future.value(tProfile)),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load profile'), findsOneWidget); // Widget uses shared error UI logic or text? 
    // Wait, line 91 uses _buildError(context, error).
    // _buildError text is 'Failed to load profile'.
    expect(find.text('Store Error'), findsOneWidget);
  });
  
  testWidgets('ProfilePageWidget shows error when Profile load fails', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          currentProfileProvider.overrideWith((ref) => Future.error('Profile Error')),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Failed to load profile'), findsOneWidget);
    expect(find.text('Profile Error'), findsOneWidget);
  });

  testWidgets('ProfilePageWidget shows error when Store is null', (tester) async {
     await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(null)),
          currentProfileProvider.overrideWith((ref) => Future.value(tProfile)),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Store not found'), findsOneWidget);
  });

  testWidgets('ProfilePageWidget shows error when Profile is null', (tester) async {
     await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(tStore)),
          currentProfileProvider.overrideWith((ref) => Future.value(null)),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Profile not found'), findsOneWidget);
  });

  testWidgets('ProfilePageWidget loads and shows content', (tester) async {
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
            currentProfileProvider.overrideWith((ref) => Future.value(tProfile)),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      // Header
      expect(find.text('My Account'), findsOneWidget);
      expect(find.text('Menu'), findsOneWidget);

      // Store/Profile Info
      expect(find.text('Test Store'), findsOneWidget);
      expect(find.text('test@example.com'), findsOneWidget);
      
      // Buttons
      expect(find.text('Edit Profile'), findsNWidgets(2)); // Menu item + Button
      expect(find.text('Log Out'), findsOneWidget);
    });
  });
}
