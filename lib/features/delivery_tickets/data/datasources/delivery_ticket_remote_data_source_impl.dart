import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/delivery_ticket.dart';
import 'delivery_ticket_remote_data_source.dart';

class DeliveryTicketRemoteDataSourceImpl
    implements DeliveryTicketRemoteDataSource {
  DeliveryTicketRemoteDataSourceImpl({required SupabaseClient supabase})
      : _supabase = supabase;

  final SupabaseClient _supabase;

  @override
  Future<CreateDeliveryTicketResult> createTicket({
    required String storeId,
    required Map<String, dynamic> pickup,
    required Map<String, dynamic> dropoff,
    required List<Map<String, dynamic>> items,
    required String selectedQuoteId,
    required double deliveryPrice,
  }) async {
    final res = await _supabase.functions.invoke(
      'delivery-tickets-create',
      body: {
        'store_id': storeId,
        'pickup': pickup,
        'dropoff': dropoff,
        'items': items,
        'selected_quote_id': selectedQuoteId,
        'delivery_price': deliveryPrice,
      },
    );
    if (res.status != 200) {
      throw Exception(res.data?.toString() ?? 'Create ticket failed');
    }
    final data = res.data as Map<String, dynamic>?;
    return CreateDeliveryTicketResult(
      ticketId: data?['ticket_id'] as String? ?? '',
      paymentUrl: data?['payment_url'] as String? ?? '',
    );
  }

  @override
  Future<DeliveryTicket?> getTicketById(String ticketId) async {
    final res = await _supabase
        .from('delivery_tickets')
        .select()
        .eq('id', ticketId)
        .maybeSingle();
    if (res == null) return null;
    final data = res;
    return DeliveryTicket(
      id: data['id'] as String,
      storeId: data['store_id'] as String,
      status: data['status'] as String?,
      paymentUrl: data['payment_url'] as String?,
      paymentStatus: data['payment_status'] as String?,
      terminalShipmentId: data['terminal_shipment_id'] as String?,
      trackingUrl: data['tracking_url'] as String?,
    );
  }

  @override
  Future<List<DeliveryTicket>> getTicketsByStore(String storeId) async {
    final res = await _supabase
        .from('delivery_tickets')
        .select()
        .eq('store_id', storeId)
        .order('created_at', ascending: false);
    final list = res as List<dynamic>;
    return list.map((e) {
      final data = e as Map<String, dynamic>;
      return DeliveryTicket(
        id: data['id'] as String,
        storeId: data['store_id'] as String,
        status: data['status'] as String?,
        paymentUrl: data['payment_url'] as String?,
        paymentStatus: data['payment_status'] as String?,
        terminalShipmentId: data['terminal_shipment_id'] as String?,
        trackingUrl: data['tracking_url'] as String?,
      );
    }).toList();
  }
}
