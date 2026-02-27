// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      stockQuantity: (json['stock_quantity'] as num?)?.toInt(),
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      category: json['category'] as String?,
      weightGrams: (json['weight_grams'] as num?)?.toDouble(),
      isPreorder: json['is_preorder'] as bool? ?? false,
      pickupAddressId: json['pickup_address_id'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'stock_quantity': instance.stockQuantity,
      'is_active': instance.isActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'category': instance.category,
      'weight_grams': instance.weightGrams,
      'is_preorder': instance.isPreorder,
      'pickup_address_id': instance.pickupAddressId,
    };
