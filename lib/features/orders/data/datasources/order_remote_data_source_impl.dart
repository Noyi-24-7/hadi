import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_item_model.dart';
import '../models/order_model.dart';

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  OrderRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<CreateOrderResult> createOrder({
    required String storeId,
    required BuyerInfo buyer,
    required DeliveryInfo delivery,
    required List<OrderItem> items,
    required String selectedQuoteId,
    required int deliveryFee,
    required int transactionFee,
    required int subtotalAmount,
    required int totalAmount,
  }) async {
    final body = {
      'store_id': storeId,
      'buyer': {
        'name': buyer.name,
        'phone': buyer.phone,
        'email': buyer.email,
      },
      'delivery': {
        'address': delivery.address,
        'city': delivery.city,
        'state': delivery.state,
        'lga': delivery.lga,
        'country': delivery.country,
      },
      'items': items
          .map((e) => {
                'product_id': e.productId,
                'variant_id': e.variantId,
                'product_variant_id': e.variantId,
                'quantity': e.quantity,
                'unit_price': e.unitPrice,
              })
          .toList(),
      'selected_quote_id': selectedQuoteId,
      'delivery_fee': deliveryFee,
      'transaction_fee': transactionFee,
      'subtotal': subtotalAmount,
      'total_amount': totalAmount,
    };
    final res = await _supabase.functions.invoke(
      'orders-create',
      body: body,
    );
    if (res.status != 200) {
      throw ServerException(res.data?['error']?.toString() ?? 'Order creation failed');
    }
    final data = res.data as Map<String, dynamic>?;
    if (data == null || data['order_id'] == null || data['payment_url'] == null) {
      throw ServerException('Invalid response from orders-create');
    }
    return CreateOrderResult(
      orderId: data['order_id'] as String,
      paymentUrl: data['payment_url'] as String,
    );
  }

  @override
  Future<OrderModel?> getOrderById(String orderId) async {
    final res = await _supabase
        .from('orders')
        .select()
        .eq('id', orderId)
        .maybeSingle();
    if (res == null) return null;
    return OrderModel.fromJson(res);
  }

  @override
  Future<List<OrderModel>> getOrdersByBuyer(String buyerId) async {
    final res = await _supabase
        .from('orders')
        .select()
        .eq('buyer_id', buyerId)
        .order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<OrderModel>> getOrdersByStore(String storeId) async {
    final res = await _supabase
        .from('orders')
        .select()
        .eq('store_id', storeId)
        .order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<OrderItemModel>> getOrderItems(String orderId) async {
    final res = await _supabase
        .from('order_items')
        .select()
        .eq('order_id', orderId);
    final list = res as List<dynamic>;
    return list
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class ServerException implements Exception {
  ServerException(this.message);
  final String message;
}
