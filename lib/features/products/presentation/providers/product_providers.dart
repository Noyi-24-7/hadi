import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/supabase_provider.dart';
import '../../../../app_config.dart';
import '../../data/datasources/mock_product_remote_data_source.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/datasources/product_remote_data_source_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_variant.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/create_variant.dart';
import '../../domain/usecases/add_product_media.dart';
import '../../domain/usecases/get_product_media.dart';
import '../../domain/entities/product_media.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/get_product.dart';
import '../../domain/usecases/get_product_variants.dart';
import '../../domain/usecases/get_products_by_store.dart';
import '../../domain/usecases/resolve_variant_for_selection.dart';
import '../../domain/usecases/update_product.dart';
import '../../domain/usecases/update_variant.dart';

part 'product_providers.g.dart';

@riverpod
ProductRemoteDataSource productRemoteDataSource(ProductRemoteDataSourceRef ref) {
  if (AppConfig.isMockMode) {
    return MockProductRemoteDataSource();
  }
  return ProductRemoteDataSourceImpl(
    supabase: ref.watch(supabaseClientProvider),
  );
}

@riverpod
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.watch(productRemoteDataSourceProvider),
  );
}

// Use cases
@riverpod
GetProduct getProduct(GetProductRef ref) {
  return GetProduct(ref.watch(productRepositoryProvider));
}

@riverpod
GetProductVariants getProductVariants(GetProductVariantsRef ref) {
  return GetProductVariants(ref.watch(productRepositoryProvider));
}

@riverpod
ResolveVariantForSelection resolveVariantForSelection(
  ResolveVariantForSelectionRef ref,
) {
  return ResolveVariantForSelection(ref.watch(productRepositoryProvider));
}

@riverpod
GetProductsByStore getProductsByStore(GetProductsByStoreRef ref) {
  return GetProductsByStore(ref.watch(productRepositoryProvider));
}

@riverpod
CreateProduct createProduct(CreateProductRef ref) {
  return CreateProduct(ref.watch(productRepositoryProvider));
}

@riverpod
UpdateProduct updateProduct(UpdateProductRef ref) {
  return UpdateProduct(ref.watch(productRepositoryProvider));
}

@riverpod
DeleteProduct deleteProduct(DeleteProductRef ref) {
  return DeleteProduct(ref.watch(productRepositoryProvider));
}

@riverpod
CreateVariant createVariant(CreateVariantRef ref) {
  return CreateVariant(ref.watch(productRepositoryProvider));
}

@riverpod
AddProductMedia addProductMedia(AddProductMediaRef ref) {
  return AddProductMedia(ref.watch(productRepositoryProvider));
}

@riverpod
GetProductMedia getProductMediaUseCase(GetProductMediaUseCaseRef ref) {
  return GetProductMedia(ref.watch(productRepositoryProvider));
}

@riverpod
Future<List<ProductMedia>> productMedia(ProductMediaRef ref, String productId) {
  final useCase = ref.watch(getProductMediaUseCaseProvider);
  return useCase(productId).then((value) => value.fold(
        (l) => throw l,
        (r) => r,
      ));
}

@riverpod
UpdateVariant updateVariant(UpdateVariantRef ref) {
  return UpdateVariant(ref.watch(productRepositoryProvider));
}

// Data providers
@riverpod
Future<Product> product(ProductRef ref, String productId) async {
  final result = await ref.watch(getProductProvider).call(productId);
  return result.fold((f) => throw Exception(f.message), (p) => p);
}

@riverpod
Future<List<ProductVariant>> productVariants(
  ProductVariantsRef ref,
  String productId,
) async {
  final result = await ref.watch(getProductVariantsProvider).call(productId);
  return result.fold((f) => throw Exception(f.message), (p) => p);
}

@riverpod
Future<List<Product>> productsByStore(
  ProductsByStoreRef ref,
  String storeId,
) async {
  final result = await ref.watch(getProductsByStoreProvider).call(storeId);
  return result.fold((f) => throw Exception(f.message), (p) => p);
}
