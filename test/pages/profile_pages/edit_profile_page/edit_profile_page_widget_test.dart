import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hadi/features/auth/domain/entities/profile.dart';
import 'package:hadi/features/auth/presentation/providers/auth_providers.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/pages/profile_pages/edit_profile_page/edit_profile_page_widget.dart';
import 'package:network_image_mock/network_image_mock.dart';

import 'package:mocktail/mocktail.dart';
import 'package:hadi/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:hadi/features/storefront/domain/usecases/update_store_use_case.dart';

// Mock Use Cases
class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}
class MockUpdateStoreUseCase extends Mock implements UpdateStoreUseCase {}

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    registerFallbackValue(const StoreEntity(
      id: 'fallback_id',
      name: 'fallback_name',
      slug: 'fallback_slug',
      description: 'fallback_desc',
      isActive: true,
    ));
  });

  const tStore = StoreEntity(
    id: 'store_1',
    name: 'Test Store',
    slug: 'test-store',
    description: 'A test store',
    isActive: true,
    rcNumber: 'RC123456',
  );

  const tProfile = Profile(
    id: 'user_1',
    role: 'merchant',
    email: 'test@example.com',
    fullName: 'Test User',
    firstName: 'Test',
    lastName: 'User',
    profileImageUrl: 'https://example.com/profile.jpg',
  );

  Widget createWidgetUnderTest() {
    return const MaterialApp(
      home: EditProfilePageWidget(),
    );
  }

  testWidgets('EditProfilePageWidget shows loading initially', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myStoreProvider.overrideWith((ref) => Completer<StoreEntity>().future),
          currentProfileProvider.overrideWith((ref) => Future.value(tProfile)),
        ],
        child: createWidgetUnderTest(),
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(SpinKitWanderingCubes), findsOneWidget);
  });

  testWidgets('EditProfilePageWidget loads and populates fields', (tester) async {
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
      expect(find.text('Edit Profile'), findsOneWidget);

      // Fields with initial values
      expect(find.widgetWithText(TextFormField, 'Test'), findsOneWidget); // First Name
      expect(find.widgetWithText(TextFormField, 'User'), findsOneWidget); // Last Name
      expect(find.widgetWithText(TextFormField, 'Test Store'), findsOneWidget); // Business Name
      expect(find.widgetWithText(TextFormField, 'RC123456'), findsOneWidget); // RC Number
    });
  });

  testWidgets('EditProfilePageWidget updates data', (tester) async {
    // Mock successful updates
    final mockUpdateProfile = MockUpdateProfileUseCase();
    final mockUpdateStore = MockUpdateStoreUseCase();
    
    when(() => mockUpdateProfile.call(
      fullName: any(named: 'fullName'),
      firstName: any(named: 'firstName'),
      lastName: any(named: 'lastName'),
      phone: any(named: 'phone'),
      profileImageUrl: any(named: 'profileImageUrl'),
    )).thenAnswer((_) async => const Right(tProfile));

    when(() => mockUpdateStore.call(any()))
      .thenAnswer((_) async => const Right(tStore));

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            myStoreProvider.overrideWith((ref) => Future.value(tStore)),
            currentProfileProvider.overrideWith((ref) => Future.value(tProfile)),
            updateProfileUseCaseProvider.overrideWithValue(mockUpdateProfile),
            updateStoreUseCaseProvider.overrideWithValue(mockUpdateStore),
          ],
          child: createWidgetUnderTest(),
        ),
      );

      await tester.pumpAndSettle();

      // Change First Name
      await tester.enterText(find.widgetWithText(TextFormField, 'Test'), 'Updated');
      
      // Change Business Name
      await tester.enterText(find.widgetWithText(TextFormField, 'Test Store'), 'Updated Store');

      // Scroll to button
      final saveButtonFinder = find.text('Save Changes');
      await tester.ensureVisible(saveButtonFinder);

      // Tap Save
      await tester.tap(saveButtonFinder);
      // Wait for async operations and animations
      await tester.pumpAndSettle();

      // Verify Use Cases were called
      verify(() => mockUpdateProfile.call(
        firstName: any(named: 'firstName'), 
        lastName: any(named: 'lastName'),
        profileImageUrl: any(named: 'profileImageUrl'),
        fullName: any(named: 'fullName'),
        phone: any(named: 'phone'),
      )).called(1);
      
      verify(() => mockUpdateStore.call(any())).called(1);

      // Snackbar success
      expect(find.text('Profile updated successfully'), findsOneWidget);
    });
  });
}
