import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/product_model.dart';
import '../models/product_variant_model.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<ProductModel?> getProductById(String id) async {
    final res = await _supabase.from('products').select().eq('id', id).maybeSingle();
    if (res == null) return null;
    return ProductModel.fromJson(res);
  }

  @override
  Future<List<ProductVariantModel>> getVariantsByProductId(String productId) async {
    final res = await _supabase
        .from('product_variants')
        .select()
        .eq('product_id', productId)
        .eq('is_active', true);
    final list = res as List<dynamic>;
    return list
        .map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ProductVariantModel?> getVariantById(String variantId) async {
    final res = await _supabase
        .from('product_variants')
        .select()
        .eq('id', variantId)
        .maybeSingle();
    if (res == null) return null;
    return ProductVariantModel.fromJson(res);
  }

  @override
  Future<List<ProductModel>> getProductsByStoreId(String storeId) async {
    final res = await _supabase
        .from('products')
        .select()
        .eq('store_id', storeId)
        .eq('is_active', true)
        .order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProductModel>> searchProducts({
    String? query,
    String? category,
    String? storeId,
  }) async {
    var queryBuilder = _supabase.from('products').select().eq('is_active', true);

    if (storeId != null) {
      queryBuilder = queryBuilder.eq('store_id', storeId);
    }

    if (category != null && category.isNotEmpty) {
      queryBuilder = queryBuilder.eq('category', category);
    }

    if (query != null && query.isNotEmpty) {
      queryBuilder = queryBuilder.ilike('name', '%$query%');
    }

    final res = await queryBuilder.order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
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
    final data = await _supabase.from('products').insert({
      'store_id': storeId,
      'name': name,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'category': category,
      'weight_grams': weightGrams,
      'is_preorder': isPreorder,
      'pickup_address_id': pickupAddressId,
      'is_active': true,
    }).select().single();

    return ProductModel.fromJson(data);
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
    final updates = <String, dynamic>{};
    if (name != null) updates['name'] = name;
    if (description != null) updates['description'] = description;
    if (price != null) updates['price'] = price;
    if (stockQuantity != null) updates['stock_quantity'] = stockQuantity;
    if (isActive != null) updates['is_active'] = isActive;
    if (category != null) updates['category'] = category;
    if (weightGrams != null) updates['weight_grams'] = weightGrams;
    if (isPreorder != null) updates['is_preorder'] = isPreorder;
    if (pickupAddressId != null) updates['pickup_address_id'] = pickupAddressId;

    final data = await _supabase
        .from('products')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return ProductModel.fromJson(data);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _supabase.from('products').delete().eq('id', id);
  }

  @override
  Future<ProductVariantModel> createVariant({
    required String productId,
    String? size,
    String? color,
    required int priceAmount,
    required int quantity,
  }) async {
    final data = await _supabase.from('product_variants').insert({
      'product_id': productId,
      'size': size,
      'color': color,
      'price_amount': priceAmount,
      'quantity': quantity,
      'is_active': true,
    }).select().single();

    return ProductVariantModel.fromJson(data);
  }

  @override
  Future<ProductVariantModel> updateVariant({
    required String id,
    int? priceAmount,
    int? quantity,
    bool? isActive,
  }) async {
    final updates = <String, dynamic>{};
    if (priceAmount != null) updates['price_amount'] = priceAmount;
    if (quantity != null) updates['quantity'] = quantity;
    if (isActive != null) updates['is_active'] = isActive;

    final data = await _supabase
        .from('product_variants')
        .update(updates)
        .eq('id', id)
        .select()
        .single();

    return ProductVariantModel.fromJson(data);
  }

  @override
  Future<void> deleteVariant(String id) async {
    await _supabase.from('product_variants').delete().eq('id', id);
  }
  @override
  Future<List<ProductMediaDbRow>> getProductMedia(String productId) async {
    return await ProductMediaTable().queryRows(
      queryFn: (q) => q
          .eqOrNull('product_id', productId)
          .order('sort_order', ascending: true),
    );
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
    return await ProductMediaTable().insert({
      'product_id': productId,
      'storage_path': storagePath,
      'public_url': publicUrl,
      'file_name': fileName,
      'file_size': fileSize,
      'sort_order': sortOrder,
      'is_video': isVideo,
    });
  }
}
