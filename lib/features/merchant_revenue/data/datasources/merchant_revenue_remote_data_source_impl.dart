import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/payout_model.dart';
import '../models/transaction_model.dart';
import 'merchant_revenue_remote_data_source.dart';

class MerchantRevenueRemoteDataSourceImpl
    implements MerchantRevenueRemoteDataSource {
  MerchantRevenueRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<List<TransactionModel>> getTransactions({
    required String storeId,
    String? type,
  }) async {
    var query = _supabase
        .from('transactions')
        .select()
        .eq('store_id', storeId);

    if (type != null && type != 'all') {
      query = query.eq('type', type);
    }
    
    final res = await query.order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PayoutModel>> getPayouts(String storeId) async {
    final res = await _supabase
        .from('payouts')
        .select()
        .eq('store_id', storeId)
        .order('initiated_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => PayoutModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Map<String, dynamic>> getRevenueStats(String storeId) async {
    // Get total revenue from successful order_payment transactions
    final revenueRes = await _supabase
        .from('transactions')
        .select('amount')
        .eq('store_id', storeId)
        .eq('type', 'order_payment')
        .eq('status', 'successful');

    final revenueList = revenueRes as List<dynamic>;
    final totalRevenue = revenueList.fold<double>(
      0.0,
      (sum, item) =>
          sum +
          ((item as Map<String, dynamic>)['amount'] as num).toDouble(),
    );

    // Get total items sold from order_items
    final itemsRes = await _supabase
        .from('order_items')
        .select('quantity, order_id!inner(store_id)')
        .eq('order_id.store_id', storeId);

    final itemsList = itemsRes as List<dynamic>;
    final totalItemsSold = itemsList.fold<int>(
      0,
      (sum, item) =>
          sum + ((item as Map<String, dynamic>)['quantity'] as num).toInt(),
    );

    return {
      'total_revenue': totalRevenue,
      'total_items_sold': totalItemsSold,
      'currency': 'NGN',
    };
  }
}
