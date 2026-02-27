import '/backend/supabase/supabase.dart';
import '../models/product_model.dart';
import '../models/product_variant_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductModel?> getProductById(String id);
  Future<List<ProductVariantModel>> getVariantsByProductId(String productId);
  Future<ProductVariantModel?> getVariantById(String variantId);

  // Product listing
  Future<List<ProductModel>> getProductsByStoreId(String storeId);
  Future<List<ProductModel>> searchProducts({
    String? query,
    String? category,
    String? storeId,
  });

  // Product management
  Future<ProductModel> createProduct({
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

  Future<ProductModel> updateProduct({
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

  Future<void> deleteProduct(String id);

  // Variant management
  Future<ProductVariantModel> createVariant({
    required String productId,
    String? size,
    String? color,
    required int priceAmount,
    required int quantity,
  });

  Future<ProductVariantModel> updateVariant({
    required String id,
    int? priceAmount,
    int? quantity,
    bool? isActive,
  });

  Future<void> deleteVariant(String id);

  Future<List<ProductMediaDbRow>> getProductMedia(String productId);

  Future<ProductMediaDbRow> addProductMedia({
    required String productId,
    required String storagePath,
    required String publicUrl,
    required String fileName,
    int? fileSize,
    required int sortOrder,
    required bool isVideo,
  });
}
