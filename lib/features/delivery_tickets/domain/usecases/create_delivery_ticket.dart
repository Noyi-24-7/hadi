import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error.dart';
import '../entities/delivery_ticket.dart';
import '../repositories/delivery_ticket_repository.dart';

class CreateDeliveryTicket {
  const CreateDeliveryTicket(this._repository);

  final DeliveryTicketRepository _repository;

  Future<Either<Failure, CreateDeliveryTicketResult>> call({
    required String storeId,
    required Map<String, dynamic> pickup,
    required Map<String, dynamic> dropoff,
    required List<Map<String, dynamic>> items,
    required String selectedQuoteId,
    required double deliveryPrice,
  }) {
    return _repository.createTicket(
      storeId: storeId,
      pickup: pickup,
      dropoff: dropoff,
      items: items,
      selectedQuoteId: selectedQuoteId,
      deliveryPrice: deliveryPrice,
    );
  }
}
