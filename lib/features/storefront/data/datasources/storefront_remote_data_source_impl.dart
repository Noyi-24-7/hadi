import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../products/data/models/product_model.dart';
import '../models/store_model.dart';
import '../models/product_variant_model.dart';
import 'storefront_remote_data_source.dart';

class StorefrontRemoteDataSourceImpl implements StorefrontRemoteDataSource {
  StorefrontRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<StoreModel?> getStoreBySlug(String slug) async {
    final res = await _supabase
        .from('stores')
        .select()
        .eq('slug', slug)
        .eq('is_active', true)
        .maybeSingle();

    if (res == null) return null;
    return StoreModel.fromJson(res);
  }

  @override
  Future<StoreModel?> getStoreByOwnerId(String ownerId) async {
    final results = await _supabase
        .from('stores')
        .select()
        .eq('owner_id', ownerId)
        .order('created_at', ascending: false)
        .limit(1);

    if (results.isEmpty) return null;
    return StoreModel.fromJson(results.first as Map<String, dynamic>);
  }

  @override
  Future<List<ProductModel>> getActiveProductsByStoreId(String storeId) async {
    final res = await _supabase
        .from('products')
        .select()
        .eq('store_id', storeId)
        .eq('is_active', true);

    final list = res as List<dynamic>;
    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<StoreModel> updateStore(StoreModel store) async {
    final data = await _supabase
        .from('stores')
        .update(store.toJson())
        .eq('id', store.id)
        .select()
        .single();
    return StoreModel.fromJson(data);
  }

  @override
  Future<List<ProductVariantModel>> getProductVariants(String productId) async {
    final response = await _supabase
        .from('product_variants')
        .select()
        .eq('product_id', productId)
        .eq('is_active', true);

    final list = response as List<dynamic>;
    return list
        .map((e) => ProductVariantModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

