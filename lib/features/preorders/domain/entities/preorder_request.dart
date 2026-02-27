import 'package:equatable/equatable.dart';

class PreorderRequest extends Equatable {
  const PreorderRequest({
    required this.id,
    required this.storeId,
    required this.productId,
    this.productVariantId,
    required this.quantity,
    required this.status,
    this.terminalShipmentId,
    this.trackingUrl,
    this.trackingEvents,
  });

  final String id;
  final String storeId;
  final String productId;
  final String? productVariantId;
  final int quantity;
  final String status;
  final String? terminalShipmentId;
  final String? trackingUrl;
  final List<dynamic>? trackingEvents;

  @override
  List<Object?> get props =>
      [id, storeId, productId, productVariantId, quantity, status,
       terminalShipmentId, trackingUrl, trackingEvents];
}
