// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: json['id'] as String?,
      orderId: json['order_id'] as String?,
      productId: json['product_id'] as String,
      productVariantId: json['product_variant_id'] as String?,
      variantId: json['variant_id'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      lineTotalAmount: (json['line_total_amount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'product_variant_id': instance.productVariantId,
      'variant_id': instance.variantId,
      'quantity': instance.quantity,
      'unit_price': instance.unitPrice,
      'line_total_amount': instance.lineTotalAmount,
    };
