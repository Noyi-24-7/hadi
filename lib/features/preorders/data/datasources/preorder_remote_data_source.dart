import '../models/preorder_request_model.dart';

abstract class PreorderRemoteDataSource {
  Future<List<PreorderRequestModel>> getByStoreId(String storeId);

  Future<PreorderRequestModel?> getById(String preorderId);

  Future<Map<String, dynamic>> createShipment(String preorderRequestId);
}
