import 'package:equatable/equatable.dart';

class Order extends Equatable {
  const Order({
    required this.id,
    required this.storeId,
    this.buyerId,
    this.status,
    required this.totalAmount,
    this.currency = 'NGN',
    this.safehavenReference,
    this.selectedDeliveryQuoteId,
    this.subtotalAmount,
    this.deliveryFee,
    this.transactionFee,
    this.paymentUrl,
    this.createdAt,
  });

  final String id;
  final String storeId;
  final String? buyerId;
  final String? status;
  final double totalAmount;
  final String currency;
  final String? safehavenReference;
  final String? selectedDeliveryQuoteId;
  final int? subtotalAmount;
  final int? deliveryFee;
  final int? transactionFee;
  final String? paymentUrl;
  final DateTime? createdAt;

  @override
  List<Object?> get props => [
        id, storeId, buyerId, status, totalAmount, currency, safehavenReference,
        selectedDeliveryQuoteId, subtotalAmount, deliveryFee, transactionFee,
        paymentUrl, createdAt,
      ];
}

class CreateOrderResult extends Equatable {
  const CreateOrderResult({
    required this.orderId,
    required this.paymentUrl,
  });

  final String orderId;
  final String paymentUrl;

  @override
  List<Object?> get props => [orderId, paymentUrl];
}
