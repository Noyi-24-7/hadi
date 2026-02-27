// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      buyerId: json['buyer_id'] as String?,
      status: json['status'] as String?,
      totalAmount: (json['total_amount'] as num).toDouble(),
      currency: json['currency'] as String?,
      safehavenReference: json['safehaven_reference'] as String?,
      selectedDeliveryQuoteId: json['selected_delivery_quote_id'] as String?,
      subtotalAmount: (json['subtotal_amount'] as num?)?.toInt(),
      deliveryFee: (json['delivery_fee'] as num?)?.toInt(),
      transactionFee: (json['transaction_fee'] as num?)?.toInt(),
      paymentUrl: json['payment_url'] as String?,
      createdAt: OrderModel._dateTimeFromJson(json['created_at'] as String?),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'buyer_id': instance.buyerId,
      'status': instance.status,
      'total_amount': instance.totalAmount,
      'currency': instance.currency,
      'safehaven_reference': instance.safehavenReference,
      'selected_delivery_quote_id': instance.selectedDeliveryQuoteId,
      'subtotal_amount': instance.subtotalAmount,
      'delivery_fee': instance.deliveryFee,
      'transaction_fee': instance.transactionFee,
      'payment_url': instance.paymentUrl,
      'created_at': instance.createdAt?.toIso8601String(),
    };
