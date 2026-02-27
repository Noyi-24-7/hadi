import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/preorder_request_model.dart';
import 'preorder_remote_data_source.dart';

class PreorderRemoteDataSourceImpl implements PreorderRemoteDataSource {
  PreorderRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<List<PreorderRequestModel>> getByStoreId(String storeId) async {
    final res = await _supabase
        .from('preorder_requests')
        .select()
        .eq('store_id', storeId)
        .order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => PreorderRequestModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PreorderRequestModel?> getById(String preorderId) async {
    final res = await _supabase
        .from('preorder_requests')
        .select()
        .eq('id', preorderId)
        .maybeSingle();
    if (res == null) return null;
    final data = res;
    return PreorderRequestModel.fromJson(data);
  }

  @override
  Future<Map<String, dynamic>> createShipment(
    String preorderRequestId,
  ) async {
    final res = await _supabase.functions.invoke(
      'preorders-create-shipment',
      body: {'preorder_request_id': preorderRequestId},
    );
    if (res.status != 200) {
      throw Exception(res.data?.toString() ?? 'Create shipment failed');
    }
    return res.data as Map<String, dynamic>;
  }
}
