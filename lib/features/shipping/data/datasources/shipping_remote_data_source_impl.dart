import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/delivery_quote_model.dart';
import 'shipping_remote_data_source.dart';

class ShippingRemoteDataSourceImpl implements ShippingRemoteDataSource {
  ShippingRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<List<DeliveryQuoteModel>> getQuotes({
    required Map<String, dynamic> pickupAddress,
    required Map<String, dynamic> deliveryAddress,
    required Map<String, dynamic> package,
  }) async {
    final res = await _supabase.functions.invoke(
      'terminal-get-quotes',
      body: {
        'pickup_address': pickupAddress,
        'delivery_address': deliveryAddress,
        'package': package,
      },
    );
    if (res.status != 200) {
      throw Exception(res.data?.toString() ?? 'Failed to get quotes');
    }
    final data = res.data as Map<String, dynamic>?;
    final list = data?['quotes'] as List<dynamic>? ?? [];
    return list
        .map((e) => DeliveryQuoteModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
