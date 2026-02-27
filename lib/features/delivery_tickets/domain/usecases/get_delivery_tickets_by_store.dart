import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/delivery_ticket.dart';
import '../repositories/delivery_ticket_repository.dart';

class GetDeliveryTicketsByStore {
  const GetDeliveryTicketsByStore(this._repository);

  final DeliveryTicketRepository _repository;

  Future<Either<Failure, List<DeliveryTicket>>> call(String storeId) {
    return _repository.getTicketsByStore(storeId);
  }
}
