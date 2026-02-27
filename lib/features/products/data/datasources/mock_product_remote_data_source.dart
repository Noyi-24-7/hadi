import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '../models/product_model.dart';
import '../models/product_variant_model.dart';
import 'product_remote_data_source.dart';

class MockProductRemoteDataSource implements ProductRemoteDataSource {
  final List<ProductMediaDbRow> _media = [];

  @override
  Future<ProductModel?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ProductModel(
      id: id,
      storeId: 'mock-store-123',
      name: 'Mock Product $id',
      description: 'This is a mock product description.',
      price: 1500.0,
      stockQuantity: 50,
      isActive: true,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<ProductVariantModel>> getVariantsByProductId(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      ProductVariantModel(
        id: 'variant-1',
        productId: productId,
        size: 'M',
        color: 'Red',
        priceAmount: 1500,
        quantity: 10,
        isActive: true,
      ),
      ProductVariantModel(
        id: 'variant-2',
        productId: productId,
        size: 'L',
        color: 'Blue',
        priceAmount: 1600,
        quantity: 5,
        isActive: true,
      ),
    ];
  }

  @override
  Future<ProductVariantModel?> getVariantById(String variantId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ProductVariantModel(
      id: variantId,
      productId: 'mock-product-id',
      size: 'M',
      color: 'Red',
      priceAmount: 1500,
      quantity: 10,
      isActive: true,
    );
  }

  @override
  Future<List<ProductModel>> getProductsByStoreId(String storeId) async {
     await Future.delayed(const Duration(milliseconds: 800));
    return [
      ProductModel(
        id: 'prod-1',
        storeId: storeId,
        name: 'Mock Product A',
        description: 'Excellent product A',
        price: 1500.0,
        isActive: true,
        stockQuantity: 50,
      ),
      ProductModel(
        id: 'prod-2',
        storeId: storeId,
        name: 'Mock Product B',
        description: 'Budget product B',
        price: 500.0,
        isActive: true,
        stockQuantity: 100,
      ),
    ];
  }

  @override
  Future<List<ProductModel>> searchProducts({
    String? query,
    String? category,
    String? storeId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
       ProductModel(
        id: 'prod-search-1',
        storeId: storeId ?? 'mock-store',
        name: 'Searched Product',
        description: 'Result for query $query',
        price: 1200.0,
        isActive: true,
        stockQuantity: 20,
      ),
    ];
  }

  @override
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
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return ProductModel(
      id: 'mock-new-product-${DateTime.now().millisecondsSinceEpoch}',
      storeId: storeId,
      name: name,
      description: description,
      price: price,
      stockQuantity: stockQuantity,
      category: category,
      weightGrams: weightGrams,
      isPreorder: isPreorder,
      pickupAddressId: pickupAddressId,
      isActive: true,
      createdAt: DateTime.now(),
    );
  }

  @override
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
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return ProductModel(
      id: id,
      storeId: 'mock-store',
      name: name ?? 'Updated Mock Product',
      description: description,
      price: price ?? 0.0,
      stockQuantity: stockQuantity,
      isActive: isActive ?? true,
      category: category,
      weightGrams: weightGrams,
      isPreorder: isPreorder ?? false,
      pickupAddressId: pickupAddressId,
    );
  }

  @override
  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<ProductVariantModel> createVariant({
    required String productId,
    String? size,
    String? color,
    required int priceAmount,
    required int quantity,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ProductVariantModel(
      id: 'mock-variant-${DateTime.now().millisecondsSinceEpoch}',
      productId: productId,
      size: size,
      color: color,
      priceAmount: priceAmount,
      quantity: quantity,
      isActive: true,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<ProductVariantModel> updateVariant({
    required String id,
    int? priceAmount,
    int? quantity,
    bool? isActive,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ProductVariantModel(
      id: id,
      productId: 'mock-product-id',
      priceAmount: priceAmount ?? 0,
      quantity: quantity ?? 0,
      isActive: isActive ?? true,
    );
  }

  @override
  Future<void> deleteVariant(String id) async {
     await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<List<ProductMediaDbRow>> getProductMedia(String productId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _media.where((m) => m.productId == productId).toList();
  }

  @override
  Future<ProductMediaDbRow> addProductMedia({
    required String productId,
    required String storagePath,
    required String publicUrl,
    required String fileName,
    int? fileSize,
    required int sortOrder,
    required bool isVideo,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final media = ProductMediaDbRow({
      'id': 'mock-media-${DateTime.now().millisecondsSinceEpoch}',
      'product_id': productId,
      'storage_path': storagePath,
      'public_url': publicUrl,
      'file_name': fileName,
      'file_size': fileSize,
      'sort_order': sortOrder,
      'is_video': isVideo,
      'created_at': DateTime.now().toIso8601String(),
    });
    _media.add(media);
    return media;
  }
}
