import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/store_entity.dart';
import '../../../products/domain/entities/product_variant.dart';

abstract class StorefrontRepository {
  Future<Either<Failure, StoreEntity>> getStoreBySlug(String slug);
  Future<Either<Failure, StoreEntity>> getStoreByOwnerId(String ownerId);
  Future<Either<Failure, List<Product>>> getActiveProductsByStoreId(
      String storeId);
  Future<Either<Failure, StoreEntity>> updateStore(StoreEntity store);
  Future<Either<Failure, List<ProductVariant>>> getProductVariants(
      String productId);
}
