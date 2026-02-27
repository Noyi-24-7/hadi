import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/delivery_quote.dart';

part 'delivery_quote_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeliveryQuoteModel {
  const DeliveryQuoteModel({
    required this.id,
    this.serviceLevel,
    this.serviceType,
    required this.providerName,
    this.priceAmount,
    this.rate,
    this.currency,
    this.etaText,
    this.category,
  });

  final String id;
  final String? serviceLevel;
  final String? serviceType;
  final String providerName;
  final int? priceAmount;
  final int? rate;
  final String? currency;
  final String? etaText;
  final String? category;

  factory DeliveryQuoteModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryQuoteModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryQuoteModelToJson(this);

  DeliveryQuote toDomain() => DeliveryQuote(
        id: id,
        serviceLevel: serviceLevel ?? serviceType ?? '',
        providerName: providerName,
        priceAmount: priceAmount ?? rate ?? 0,
        currency: currency ?? 'NGN',
        etaText: etaText,
      );
}
