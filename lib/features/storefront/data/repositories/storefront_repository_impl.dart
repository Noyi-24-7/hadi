import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../../products/domain/entities/product.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/repositories/storefront_repository.dart';
import '../datasources/storefront_remote_data_source.dart';
import '../models/store_model.dart';
import '../../../products/domain/entities/product_variant.dart';

class StorefrontRepositoryImpl implements StorefrontRepository {
  StorefrontRepositoryImpl({required StorefrontRemoteDataSource remote})
      : _remote = remote;

  final StorefrontRemoteDataSource _remote;

  @override
  Future<Either<Failure, StoreEntity>> getStoreBySlug(String slug) async {
    try {
      final model = await _remote.getStoreBySlug(slug);
      if (model == null) {
        return left(const ValidationFailure('Store not found'));
      }
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StoreEntity>> getStoreByOwnerId(String ownerId) async {
    try {
      final model = await _remote.getStoreByOwnerId(ownerId);
      if (model == null) {
        return left(const ValidationFailure('Store not found'));
      }
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getActiveProductsByStoreId(
    String storeId,
  ) async {
    try {
      final models = await _remote.getActiveProductsByStoreId(storeId);
      return right(models.map<Product>((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, StoreEntity>> updateStore(StoreEntity store) async {
    try {
      final model = await _remote.updateStore(StoreModel.fromDomain(store));
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductVariant>>> getProductVariants(
      String productId) async {
    try {
      final variants = await _remote.getProductVariants(productId);
      return right(variants.map<ProductVariant>((v) => v.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
