// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preorder_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreorderRequestModel _$PreorderRequestModelFromJson(
        Map<String, dynamic> json) =>
    PreorderRequestModel(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      productId: json['product_id'] as String,
      productVariantId: json['product_variant_id'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      status: json['status'] as String,
      terminalShipmentId: json['terminal_shipment_id'] as String?,
      trackingUrl: json['tracking_url'] as String?,
      trackingEvents: json['tracking_events'] as List<dynamic>?,
      requestedAt: json['requested_at'] == null
          ? null
          : DateTime.parse(json['requested_at'] as String),
      lastResentAt: json['last_resent_at'] == null
          ? null
          : DateTime.parse(json['last_resent_at'] as String),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$PreorderRequestModelToJson(
        PreorderRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'product_id': instance.productId,
      'product_variant_id': instance.productVariantId,
      'quantity': instance.quantity,
      'status': instance.status,
      'terminal_shipment_id': instance.terminalShipmentId,
      'tracking_url': instance.trackingUrl,
      'tracking_events': instance.trackingEvents,
      'requested_at': instance.requestedAt?.toIso8601String(),
      'last_resent_at': instance.lastResentAt?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
