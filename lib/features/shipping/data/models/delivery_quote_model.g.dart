// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryQuoteModel _$DeliveryQuoteModelFromJson(Map<String, dynamic> json) =>
    DeliveryQuoteModel(
      id: json['id'] as String,
      serviceLevel: json['service_level'] as String?,
      serviceType: json['service_type'] as String?,
      providerName: json['provider_name'] as String,
      priceAmount: (json['price_amount'] as num?)?.toInt(),
      rate: (json['rate'] as num?)?.toInt(),
      currency: json['currency'] as String?,
      etaText: json['eta_text'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$DeliveryQuoteModelToJson(DeliveryQuoteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'service_level': instance.serviceLevel,
      'service_type': instance.serviceType,
      'provider_name': instance.providerName,
      'price_amount': instance.priceAmount,
      'rate': instance.rate,
      'currency': instance.currency,
      'eta_text': instance.etaText,
      'category': instance.category,
    };
