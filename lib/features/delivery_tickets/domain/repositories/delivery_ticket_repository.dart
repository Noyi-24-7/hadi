import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/delivery_ticket.dart';

abstract class DeliveryTicketRepository {
  Future<Either<Failure, CreateDeliveryTicketResult>> createTicket({
    required String storeId,
    required Map<String, dynamic> pickup,
    required Map<String, dynamic> dropoff,
    required List<Map<String, dynamic>> items,
    required String selectedQuoteId,
    required double deliveryPrice,
  });

  Future<Either<Failure, DeliveryTicket>> getTicketById(String ticketId);

  Future<Either<Failure, List<DeliveryTicket>>> getTicketsByStore(
    String storeId,
  );
}
