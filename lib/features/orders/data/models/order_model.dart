import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/order.dart';

part 'order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderModel {
  const OrderModel({
    required this.id,
    required this.storeId,
    this.buyerId,
    this.status,
    required this.totalAmount,
    this.currency,
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
  final String? currency;
  final String? safehavenReference;
  final String? selectedDeliveryQuoteId;
  final int? subtotalAmount;
  final int? deliveryFee;
  final int? transactionFee;
  final String? paymentUrl;
  @JsonKey(fromJson: _dateTimeFromJson)
  final DateTime? createdAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  Order toDomain() => Order(
        id: id,
        storeId: storeId,
        buyerId: buyerId,
        status: status,
        totalAmount: totalAmount,
        currency: currency ?? 'NGN',
        safehavenReference: safehavenReference,
        selectedDeliveryQuoteId: selectedDeliveryQuoteId,
        subtotalAmount: subtotalAmount,
        deliveryFee: deliveryFee,
        transactionFee: transactionFee,
        paymentUrl: paymentUrl,
        createdAt: createdAt,
      );

  static DateTime? _dateTimeFromJson(String? value) =>
      value != null ? DateTime.tryParse(value) : null;
}
