import '../../../products/data/models/product_model.dart';
import '../models/store_model.dart';
import '../models/product_variant_model.dart';

abstract class StorefrontRemoteDataSource {
  Future<StoreModel?> getStoreBySlug(String slug);
  Future<StoreModel?> getStoreByOwnerId(String ownerId);
  Future<List<ProductModel>> getActiveProductsByStoreId(String storeId);
  Future<StoreModel> updateStore(StoreModel store);
  Future<List<ProductVariantModel>> getProductVariants(String productId);
}

