// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      orderId: json['order_id'] as String?,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      provider: json['provider'] as String?,
      reference: json['reference'] as String?,
      status: json['status'] as String,
      meta: json['meta'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'order_id': instance.orderId,
      'type': instance.type,
      'amount': instance.amount,
      'currency': instance.currency,
      'provider': instance.provider,
      'reference': instance.reference,
      'status': instance.status,
      'meta': instance.meta,
      'created_at': instance.createdAt.toIso8601String(),
    };
