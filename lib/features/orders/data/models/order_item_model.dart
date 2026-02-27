import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/order_item.dart';

part 'order_item_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderItemModel {
  const OrderItemModel({
    this.id,
    this.orderId,
    required this.productId,
    this.productVariantId, // Preferred field
    this.variantId, // Legacy field
    required this.quantity,
    required this.unitPrice,
    this.lineTotalAmount,
  });

  final String? id;
  final String? orderId;
  final String productId;
  final String? productVariantId; // Use this consistently
  final String? variantId; // For backward compatibility
  final int quantity;
  final double unitPrice;
  final double? lineTotalAmount;

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItem toDomain() => OrderItem(
        productId: productId,
        variantId: productVariantId ?? variantId, // Prefer productVariantId
        quantity: quantity,
        unitPrice: unitPrice,
        lineTotalAmount: lineTotalAmount,
      );

  factory OrderItemModel.fromDomain(OrderItem item) => OrderItemModel(
        productId: item.productId,
        productVariantId: item.variantId,
        quantity: item.quantity,
        unitPrice: item.unitPrice,
        lineTotalAmount: item.lineTotalAmount,
      );
}
