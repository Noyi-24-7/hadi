// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayoutModel _$PayoutModelFromJson(Map<String, dynamic> json) => PayoutModel(
      id: json['id'] as String,
      storeId: json['store_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      provider: json['provider'] as String?,
      safehavenReference: json['safehaven_reference'] as String?,
      status: json['status'] as String,
      initiatedAt: DateTime.parse(json['initiated_at'] as String),
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      meta: json['meta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PayoutModelToJson(PayoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'store_id': instance.storeId,
      'amount': instance.amount,
      'currency': instance.currency,
      'provider': instance.provider,
      'safehaven_reference': instance.safehavenReference,
      'status': instance.status,
      'initiated_at': instance.initiatedAt.toIso8601String(),
      'paid_at': instance.paidAt?.toIso8601String(),
      'meta': instance.meta,
    };
