// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVariantModel _$ProductVariantModelFromJson(Map<String, dynamic> json) =>
    ProductVariantModel(
      id: json['id'] as String,
      productId: json['product_id'] as String,
      size: json['size'] as String?,
      color: json['color'] as String?,
      priceAmount: (json['price_amount'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ProductVariantModelToJson(
        ProductVariantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'size': instance.size,
      'color': instance.color,
      'price_amount': instance.priceAmount,
      'quantity': instance.quantity,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
    };
