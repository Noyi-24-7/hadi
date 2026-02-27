import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/product.dart';
import '../entities/product_variant.dart';
import '../entities/product_media.dart';

abstract class ProductRepository {
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<ProductVariant>>> getVariantsByProductId(String productId);
  Future<Either<Failure, ProductVariant?>> getVariantById(String variantId);

  // Product listing
  Future<Either<Failure, List<Product>>> getProductsByStoreId(String storeId);
  Future<Either<Failure, List<Product>>> searchProducts({
    String? query,
    String? category,
    String? storeId,
  });

  // Product management
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
  });

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
  });

  Future<Either<Failure, Unit>> deleteProduct(String id);

  // Variant management
  Future<Either<Failure, ProductVariant>> createVariant({
    required String productId,
    String? size,
    String? color,
    required int priceAmount,
    required int quantity,
  });

  Future<Either<Failure, ProductVariant>> updateVariant({
    required String id,
    int? priceAmount,
    int? quantity,
    bool? isActive,
  });

  Future<Either<Failure, Unit>> deleteVariant(String id);

  Future<Either<Failure, List<ProductMedia>>> getProductMedia(String productId);

  Future<Either<Failure, ProductMedia>> addProductMedia({
    required String productId,
    required String storagePath,
    required String publicUrl,
    required String fileName,
    int? fileSize,
    required int sortOrder,
    required bool isVideo,
  });
}
