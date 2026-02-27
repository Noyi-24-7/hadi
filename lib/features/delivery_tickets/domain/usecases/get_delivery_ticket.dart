import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/delivery_ticket.dart';
import '../repositories/delivery_ticket_repository.dart';

class GetDeliveryTicket {
  const GetDeliveryTicket(this._repository);

  final DeliveryTicketRepository _repository;

  Future<Either<Failure, DeliveryTicket>> call(String ticketId) {
    return _repository.getTicketById(ticketId);
  }
}
