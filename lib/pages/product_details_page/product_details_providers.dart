import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/app_config.dart';
import '/backend/supabase/supabase.dart';
import '/core/di/supabase_provider.dart';
import '/features/products/data/datasources/product_remote_data_source_impl.dart';
import '/features/products/data/repositories/product_repository_impl.dart';
import '/features/products/domain/entities/product.dart';
import '/features/products/domain/entities/product_variant.dart';
import '/features/products/domain/usecases/get_product.dart';
import '/features/products/domain/usecases/get_product_variants.dart';

/// Manual repository provider (avoiding code generation)
final _productRepositoryProvider = Provider((ref) {
  final dataSource = ProductRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
  return ProductRepositoryImpl(remoteDataSource: dataSource);
});

final _getProductUseCaseProvider = Provider((ref) {
  return GetProduct(ref.watch(_productRepositoryProvider));
});

final _getProductVariantsUseCaseProvider = Provider((ref) {
  return GetProductVariants(ref.watch(_productRepositoryProvider));
});

/// Provider to get product by ID
final productByIdProvider = FutureProvider.family<Product, String>((ref, productId) async {
  if (AppConfig.isMockMode) {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Product(
      id: 'prod-123',
      storeId: 'store-123',
      name: 'Mock Product Details',
      description: 'This is a detailed description of the mock product.',
      price: 2500.0,
      isActive: true,
      stockQuantity: 10,
    );
  }

  final useCase = ref.watch(_getProductUseCaseProvider);
  final result = await useCase(productId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (product) => product,
  );
});

/// Provider to get product variants by product ID
final productVariantsProvider = FutureProvider.family<List<ProductVariant>, String>((ref, productId) async {
  if (AppConfig.isMockMode) {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      const ProductVariant(
        id: 'var-1',
        productId: 'prod-123',
        color: 'Red',
        size: 'L',
        priceAmount: 250000, // in kobo
        quantity: 5,
      ),
      const ProductVariant(
        id: 'var-2',
        productId: 'prod-123',
        color: 'Blue',
        size: 'M',
        priceAmount: 250000,
        quantity: 3,
      ),
    ];
  }

  final useCase = ref.watch(_getProductVariantsUseCaseProvider);
  final result = await useCase(productId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (variants) => variants,
  );
});

/// Provider to get product media by product ID
/// Note: Using Supabase directly — no domain entity for ProductMedia yet
final productMediaProvider = FutureProvider.family<List<ProductMediaDbRow>, String>((ref, productId) async {
  if (AppConfig.isMockMode) {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ProductMediaDbRow({
        'id': 'media-1',
        'product_id': 'prod-123',
        'storage_path': 'mock/path/1',
        'public_url': 'https://via.placeholder.com/300',
        'sort_order': 1,
        'created_at': DateTime.now().toIso8601String(),
      }),
      ProductMediaDbRow({
        'id': 'media-2',
        'product_id': 'prod-123',
        'storage_path': 'mock/path/2',
        'public_url': 'https://via.placeholder.com/300/0000FF/808080',
        'sort_order': 2,
        'created_at': DateTime.now().toIso8601String(),
      }),
    ];
  }

  final rows = await ProductMediaTable().queryRows(
    queryFn: (q) => q
        .eq('product_id', productId)
        .order('sort_order', ascending: true),
  );
  return rows;
});
