import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/app_config.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../../auth/supabase_auth/auth_util.dart';
import '../../data/datasources/storefront_remote_data_source_impl.dart';
import '../../data/datasources/storefront_remote_data_source.dart';
import '../../data/repositories/storefront_repository_impl.dart';
import '../../domain/repositories/storefront_repository.dart';
import '../../domain/entities/store_entity.dart';
import '../../../products/domain/entities/product.dart';
import '../../domain/usecases/get_store_by_slug.dart';
import '../../domain/usecases/get_store_by_owner_id.dart';
import '../../domain/usecases/get_active_products.dart';
import '../../domain/usecases/update_store_use_case.dart';
import '../../domain/usecases/get_product_variants.dart';
import '../../../products/domain/entities/product_variant.dart';
import '/backend/supabase/supabase.dart';

// Data source provider
final Provider<StorefrontRemoteDataSource> storefrontRemoteDataSourceProvider = Provider((ref) {
  return StorefrontRemoteDataSourceImpl(
    supabase: SupaFlow.client,
  );
});

// Repository provider
final Provider<StorefrontRepository> storefrontRepositoryProvider = Provider((ref) {
  return StorefrontRepositoryImpl(
    remote: ref.watch(storefrontRemoteDataSourceProvider),
  );
});

// Use case providers
final getStoreBySlugProvider = Provider((ref) {
  return GetStoreBySlug(ref.watch(storefrontRepositoryProvider));
});

final getStoreByOwnerIdProvider = Provider((ref) {
  return GetStoreByOwnerId(ref.watch(storefrontRepositoryProvider));
});

final getActiveProductsProvider = Provider((ref) {
  return GetActiveProducts(ref.watch(storefrontRepositoryProvider));
});

final updateStoreUseCaseProvider = Provider((ref) {
  return UpdateStoreUseCase(ref.watch(storefrontRepositoryProvider));
});

final getProductVariantsUseCaseProvider = Provider((ref) {
  return GetProductVariantsUseCase(ref.watch(storefrontRepositoryProvider));
});

// State providers
final storeProvider = FutureProvider.family<StoreEntity, String>((ref, slug) async {
  final useCase = ref.watch(getStoreBySlugProvider);
  final result = await useCase(slug);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (store) => store,
  );
});

final storeProductsProvider = FutureProvider.family<List<Product>, String>((ref, storeId) async {
  if (AppConfig.isMockMode) {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      const Product(
        id: 'prod-1',
        storeId: 'store-123',
        name: 'Mock Product A',
        description: 'Excellent product A',
        price: 1500.0,
        isActive: true,
        stockQuantity: 50,
      ),
      const Product(
        id: 'prod-2',
        storeId: 'store-123',
        name: 'Mock Product B',
        description: 'Budget product B',
        price: 500.0,
        isActive: true,
        stockQuantity: 100,
      ),
    ];
  }

  final useCase = ref.watch(getActiveProductsProvider);
  final result = await useCase(storeId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (products) => products,
  );
});

final productVariantsProvider =
    FutureProvider.family<List<ProductVariant>, String>((ref, productId) async {
  final useCase = ref.watch(getProductVariantsUseCaseProvider);
  final result = await useCase(productId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (variants) => variants,
  );
});

final myStoreProvider = FutureProvider<StoreEntity?>((ref) async {
  if (AppConfig.isMockMode) {
    await Future.delayed(const Duration(milliseconds: 500));
    return const StoreEntity(
      id: 'store-123',
      name: 'My Mock Store',
      slug: 'my-mock-store',
      description: 'This is my mock store description.',
      isActive: true,
    );
  }

  final userId = currentUserUid;
  if (userId.isEmpty) return null;

  final useCase = ref.watch(getStoreByOwnerIdProvider);
  final result = await useCase(userId);

  return result.fold(
    (failure) => null, // Return null if not found or error, or handle explicitly
    (store) => store,
  );
});
