import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_variant.dart';
import '../../domain/entities/product_media.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required ProductRemoteDataSource remoteDataSource})
      : _remote = remoteDataSource;

  final ProductRemoteDataSource _remote;

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final model = await _remote.getProductById(id);
      if (model == null) return left(const ValidationFailure('Product not found'));
      return right(model.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductVariant>>> getVariantsByProductId(
    String productId,
  ) async {
    try {
      final models = await _remote.getVariantsByProductId(productId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductVariant?>> getVariantById(String variantId) async {
    try {
      final model = await _remote.getVariantById(variantId);
      return right(model?.toDomain());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByStoreId(String storeId) async {
    try {
      final models = await _remote.getProductsByStoreId(storeId);
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts({
    String? query,
    String? category,
    String? storeId,
  }) async {
    try {
      final models = await _remote.searchProducts(
        query: query,
        category: category,
        storeId: storeId,
      );
      return right(models.map((m) => m.toDomain()).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> createProduct({
    required String storeId,
    required String name,
    String? description,
    required double price,
    int? stockQuantity,
    String? category,
    double? weightGrams,
    bool isPreorder = false,
    String? pickupAddressId,
  }) async {
    try {
      final model = await _remote.createProduct(
        storeId: storeId,
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        category: category,
        weightGrams: weightGrams,
        isPreorder: isPreorder,
        pickupAddressId: pickupAddressId,
      );
      return right(model.toDomain());
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct({
    required String id,
    String? name,
    String? description,
    double? price,
    int? stockQuantity,
    bool? isActive,
    String? category,
    double? weightGrams,
    bool? isPreorder,
    String? pickupAddressId,
  }) async {
    try {
      final model = await _remote.updateProduct(
        id: id,
        name: name,
        description: description,
        price: price,
        stockQuantity: stockQuantity,
        isActive: isActive,
        category: category,
        weightGrams: weightGrams,
        isPreorder: isPreorder,
        pickupAddressId: pickupAddressId,
      );
      return right(model.toDomain());
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(String id) async {
    try {
      await _remote.deleteProduct(id);
      return right(unit);
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductVariant>> createVariant({
    required String productId,
    String? size,
    String? color,
    required int priceAmount,
    required int quantity,
  }) async {
    try {
      final model = await _remote.createVariant(
        productId: productId,
        size: size,
        color: color,
        priceAmount: priceAmount,
        quantity: quantity,
      );
      return right(model.toDomain());
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductVariant>> updateVariant({
    required String id,
    int? priceAmount,
    int? quantity,
    bool? isActive,
  }) async {
    try {
      final model = await _remote.updateVariant(
        id: id,
        priceAmount: priceAmount,
        quantity: quantity,
        isActive: isActive,
      );
      return right(model.toDomain());
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteVariant(String id) async {
    try {
      await _remote.deleteVariant(id);
      return right(unit);
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductMedia>>> getProductMedia(String productId) async {
    try {
      final rows = await _remote.getProductMedia(productId);
      return right(rows.map((r) => ProductMedia(
        id: r.id,
        productId: r.productId,
        storagePath: r.storagePath,
        publicUrl: r.publicUrl ?? '',
        fileName: r.fileName ?? '',
        fileSize: r.fileSize,
        sortOrder: r.sortOrder ?? 0,
        isVideo: r.isVideo ?? false,
        createdAt: r.createdAt,
      )).toList());
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductMedia>> addProductMedia({
    required String productId,
    required String storagePath,
    required String publicUrl,
    required String fileName,
    int? fileSize,
    required int sortOrder,
    required bool isVideo,
  }) async {
    try {
      final r = await _remote.addProductMedia(
        productId: productId,
        storagePath: storagePath,
        publicUrl: publicUrl,
        fileName: fileName,
        fileSize: fileSize,
        sortOrder: sortOrder,
        isVideo: isVideo,
      );
      return right(ProductMedia(
        id: r.id,
        productId: r.productId,
        storagePath: r.storagePath,
        publicUrl: r.publicUrl ?? '',
        fileName: r.fileName ?? '',
        fileSize: r.fileSize,
        sortOrder: r.sortOrder ?? 0,
        isVideo: r.isVideo ?? false,
        createdAt: r.createdAt,
      ));
    } on PostgrestException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
