import 'package:equatable/equatable.dart';

class DeliveryTicket extends Equatable {
  const DeliveryTicket({
    required this.id,
    required this.storeId,
    this.status,
    this.paymentUrl,
    this.paymentStatus,
    this.terminalShipmentId,
    this.trackingUrl,
  });

  final String id;
  final String storeId;
  final String? status;
  final String? paymentUrl;
  final String? paymentStatus;
  final String? terminalShipmentId;
  final String? trackingUrl;

  @override
  List<Object?> get props =>
      [id, storeId, status, paymentUrl, paymentStatus, terminalShipmentId, trackingUrl];
}

class CreateDeliveryTicketResult extends Equatable {
  const CreateDeliveryTicketResult({
    required this.ticketId,
    required this.paymentUrl,
  });

  final String ticketId;
  final String paymentUrl;

  @override
  List<Object?> get props => [ticketId, paymentUrl];
}
