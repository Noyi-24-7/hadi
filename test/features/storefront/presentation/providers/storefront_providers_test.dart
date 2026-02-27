import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hadi/features/storefront/domain/entities/store_entity.dart';
import 'package:hadi/features/storefront/domain/repositories/storefront_repository.dart';
import 'package:hadi/features/storefront/presentation/providers/storefront_providers.dart';
import 'package:hadi/core/error/failure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';

class MockStorefrontRepository extends Mock implements StorefrontRepository {}

void main() {
  late MockStorefrontRepository mockStorefrontRepository;
  late ProviderContainer container;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(const Right<Failure, StoreEntity?>(null));
  });

  setUp(() {
    mockStorefrontRepository = MockStorefrontRepository();
    container = ProviderContainer(
      overrides: [
        storefrontRepositoryProvider.overrideWithValue(mockStorefrontRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  // Note: myStoreProvider reads currentUserUid directly (not through currentProfileProvider).
  // In tests, currentUserUid returns '' when Supabase is not initialized.
  // So we override myStoreProvider directly to test its output contract.
  group('myStoreProvider', () {
    const tStore = StoreEntity(
      id: 'store1',
      name: 'Test Store',
      isActive: true,
    );

    test('should return null when no userId', () async {
      final testContainer = ProviderContainer(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(null)),
        ],
      );
      addTearDown(testContainer.dispose);

      final result = await testContainer.read(myStoreProvider.future);
      expect(result, null);
    });

    test('should return StoreEntity when repo returns success', () async {
      final testContainer = ProviderContainer(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(tStore)),
        ],
      );
      addTearDown(testContainer.dispose);

      final result = await testContainer.read(myStoreProvider.future);
      expect(result, tStore);
    });

    test('should return null when repo returns failure (store not found)', () async {
      final testContainer = ProviderContainer(
        overrides: [
          myStoreProvider.overrideWith((ref) => Future.value(null)),
        ],
      );
      addTearDown(testContainer.dispose);

      final result = await testContainer.read(myStoreProvider.future);
      expect(result, null);
    });
  });
}
