import '../../domain/entities/delivery_ticket.dart';

abstract class DeliveryTicketRemoteDataSource {
  Future<CreateDeliveryTicketResult> createTicket({
    required String storeId,
    required Map<String, dynamic> pickup,
    required Map<String, dynamic> dropoff,
    required List<Map<String, dynamic>> items,
    required String selectedQuoteId,
    required double deliveryPrice,
  });

  Future<DeliveryTicket?> getTicketById(String ticketId);

  Future<List<DeliveryTicket>> getTicketsByStore(String storeId);
}
