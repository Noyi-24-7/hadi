import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/delivery_ticket.dart';
import '../../domain/repositories/delivery_ticket_repository.dart';
import '../datasources/delivery_ticket_remote_data_source.dart';

class DeliveryTicketRepositoryImpl implements DeliveryTicketRepository {
  DeliveryTicketRepositoryImpl({
    required DeliveryTicketRemoteDataSource remote,
  }) : _remote = remote;

  final DeliveryTicketRemoteDataSource _remote;

  @override
  Future<Either<Failure, CreateDeliveryTicketResult>> createTicket({
    required String storeId,
    required Map<String, dynamic> pickup,
    required Map<String, dynamic> dropoff,
    required List<Map<String, dynamic>> items,
    required String selectedQuoteId,
    required double deliveryPrice,
  }) async {
    try {
      final result = await _remote.createTicket(
        storeId: storeId,
        pickup: pickup,
        dropoff: dropoff,
        items: items,
        selectedQuoteId: selectedQuoteId,
        deliveryPrice: deliveryPrice,
      );
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeliveryTicket>> getTicketById(
    String ticketId,
  ) async {
    try {
      final ticket = await _remote.getTicketById(ticketId);
      if (ticket == null) {
        return left(const ValidationFailure('Delivery ticket not found'));
      }
      return right(ticket);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DeliveryTicket>>> getTicketsByStore(
    String storeId,
  ) async {
    try {
      final tickets = await _remote.getTicketsByStore(storeId);
      return right(tickets);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
